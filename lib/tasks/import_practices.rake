desc "Import practices from CSV wth date, minutes, notes"

task import_practices: [:environment] do
  require 'csv'
  opened_file = File.open("#{Rails.root}/lib/tasks/practices.csv")
  options = { headers: true, col_sep: ',' }
  CSV.foreach(opened_file, **options) do |row|

    # map the CSV columns to your database columns
    practice_hash = {}
    practice_hash[:user_id] = 1
    practice_hash[:practice_date] = row['date']
    practice_hash[:minutes] = row['minutes']
    practice_hash[:notes] = row['notes']

    Practice.find_or_create_by!(practice_hash)
  end

end