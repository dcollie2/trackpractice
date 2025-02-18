# frozen_string_literal: true

require 'test_helper'

class SongsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @song = create(:song)
    @user = @song.user
    sign_in @user
  end

  test 'should get index' do
    get songs_url
    assert_response :success
  end

  test 'should get new' do
    get new_song_url
    assert_response :success
  end

  test 'should create song' do
    assert_difference('Song.count') do
      post songs_url,
           params: { song: { chords: @song.chords, lyrics: @song.lyrics, shared: @song.shared, title: @song.title,
                             user_id: @song.user_id } }
    end

    assert_redirected_to song_url(Song.last)
  end

  test 'should not create song with invalid params' do
    assert_no_difference('Song.count') do
      post songs_url, params: { song: { title: '', artist: '' } }
    end

    assert_response :unprocessable_entity
  end

  test 'should show song' do
    get song_url(@song)
    assert_response :success
  end

  test 'should get edit' do
    get edit_song_url(@song)
    assert_response :success
  end

  test 'should update song' do
    patch song_url(@song),
          params: { song: { chords: @song.chords, lyrics: @song.lyrics, shared: @song.shared, title: @song.title,
                            user_id: @song.user_id } }
    assert_redirected_to song_url(@song)
  end

  test 'should fail to update song with invalid parameters' do
    patch song_url(@song), params: { song: { title: '', artist: '' } }
    assert_response :unprocessable_entity
  end

  test 'should destroy song' do
    assert_difference('Song.count', -1) do
      delete song_url(@song)
    end

    assert_redirected_to songs_url
  end
end
