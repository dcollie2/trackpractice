# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class SongsTest < ApplicationSystemTestCase
  setup do
    @song = create(:song)
    login_as @song.user
  end

  test 'index displays song and header' do
    visit songs_url

    assert_selector 'h1', text: 'Songs'
    assert_text @song.title
  end

  test 'index does not display icons when lyrics and chords are missing' do
    @song.update(lyrics: '', chords: '')

    visit songs_url

    assert_no_selector 'i.bi-check-circle-fill'
  end

  test 'index displays icons when lyrics are present' do
    @song.update(lyrics: 'has lyrics', chords: '')

    visit songs_url

    assert_selector 'i.bi-check-circle-fill'
  end

  test 'index displays icons when chords are present' do
    @song.update(lyrics: '', chords: 'has chords')

    visit songs_url

    assert_selector 'i.bi-check-circle-fill'
  end

  test 'should create song' do
    visit songs_url
    click_on 'New Song'

    fill_in 'Title', with: 'title'
    fill_in_rich_text_area 'Chords', with: 'chords'
    fill_in_rich_text_area 'Lyrics', with: 'lyrics'
    click_on 'Update Song'

    assert_text 'Song was successfully created'
  end

  test 'should update Song' do
    visit song_url(@song)
    click_on 'Edit Song', match: :first

    fill_in_rich_text_area 'Chords', with: @song.chords
    fill_in_rich_text_area 'Lyrics', with: @song.lyrics
    check 'Shared' if @song.shared
    fill_in 'Title', with: @song.title
    click_on 'Update Song'

    assert_text 'Song was successfully updated'
  end

  test 'should destroy Song' do
    visit song_url(@song)
    accept_alert 'Are you sure?' do
      click_on 'Delete Song', match: :first
    end

    assert_text 'Song was successfully destroyed'
  end
end
