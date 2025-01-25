# frozen_string_literal: true

FactoryBot.define do
  factory :song do
    title { 'Title' }
    lyrics { 'Lyrics' }
    chords { 'Chords' }
    shared { false }
    user
  end
end
