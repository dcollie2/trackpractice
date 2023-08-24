json.extract! song, :id, :title, :lyrics, :chords, :shared, :user_id, :created_at, :updated_at
json.url song_url(song, format: :json)
