require "test_helper"
require "application_system_test_case"

class SongsTest < ApplicationSystemTestCase
  setup do
    @song = songs(:one)
    login_as @song.user
  end

  test "visiting the index" do
    visit songs_url
    assert_selector "h1", text: "Songs"
  end

  test "should create song" do
    visit songs_url
    click_on "New Song"

    fill_in "Chords", with: @song.chords
    fill_in "Lyrics", with: @song.lyrics
    check "Shared" if @song.shared
    fill_in "Title", with: @song.title
    click_on "Create Song"

    assert_text "Song was successfully created"
  end

  test "should update Song" do
    visit song_url(@song)
    click_on "Edit Song", match: :first

    fill_in "Chords", with: @song.chords
    fill_in "Lyrics", with: @song.lyrics
    check "Shared" if @song.shared
    fill_in "Title", with: @song.title
    click_on "Update Song"

    assert_text "Song was successfully updated"
  end

  test "should destroy Song" do
    visit song_url(@song)
    accept_alert "Are you sure?" do
      click_on "Delete Song", match: :first
    end

    assert_text "Song was successfully destroyed"
  end
end
