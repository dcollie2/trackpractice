# frozen_string_literal: true

# One-time copy of every table from the old Fly Postgres cluster into SQLite.
#
#   fly ssh console -C "bin/rails db:import_from_postgres"
#
# Source is ENV["DATABASE_URL"] (the Postgres URL); destination is the app's
# configured SQLite database. Refuses to run if the destination already has
# rows, so it can't double-import. Delete this file and the pg gem afterwards.
namespace :db do
  desc 'Copy all tables from the Postgres database in DATABASE_URL into SQLite'
  task import_from_postgres: :environment do
    source_url = ENV.fetch('DATABASE_URL') { abort 'DATABASE_URL (the Postgres source) is not set' }
    abort 'Source URL is not Postgres' unless source_url.start_with?('postgres')

    # Active Record needs a named class to own a connection.
    pg_source = Object.const_set(:PostgresImportSource, Class.new(ActiveRecord::Base)) # rubocop:disable Rails/ApplicationRecord
    pg_source.abstract_class = true
    pg_source.establish_connection(source_url)
    source = pg_source.connection
    dest = ActiveRecord::Base.connection
    abort 'Destination is not SQLite' unless dest.adapter_name =~ /sqlite/i

    tables = dest.tables - %w[schema_migrations ar_internal_metadata]
    tables.each do |table|
      count = dest.select_value("SELECT COUNT(*) FROM #{dest.quote_table_name(table)}").to_i
      abort "Destination table #{table} already has #{count} rows; refusing to import" if count.positive?
    end

    dest.execute('PRAGMA foreign_keys = OFF')
    dest.transaction do
      tables.each do |table|
        rows = source.select_all("SELECT * FROM #{source.quote_table_name(table)}").to_a
        next if rows.empty?

        columns = rows.first.keys.map { |c| dest.quote_column_name(c) }.join(', ')
        rows.each_slice(500) do |slice|
          values = slice.map { |row| "(#{row.values.map { |v| dest.quote(v) }.join(', ')})" }.join(",\n")
          dest.execute("INSERT INTO #{dest.quote_table_name(table)} (#{columns}) VALUES #{values}")
        end
        puts format('%<table>-30s %<count>6d rows', table: table, count: rows.size)
      end
    end
    puts 'Import complete.'
  end
end
