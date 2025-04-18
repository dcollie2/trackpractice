# frozen_string_literal: true

require 'test_helper'

class SongTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @song = create(:song, user: @user)
  end
  test 'should not save song without title' do
    @song.title = ''
    assert_not @song.save, 'Saved the song without a title'
  end

  test 'should save song with title' do
    assert @song.save, 'Saved the song with a title'
  end

  test 'total practice time returns zero if there are no practices' do
    assert @song.total_practice_time.zero?, 'total_practice_time should be zero'
  end

  test 'total practice time returns sum of minutes for all practices' do
    practice = create(:practice, user: @user, song: @song, minutes: 1)
    practice.dup.save
    assert @song.total_practice_time == 2, 'total_practice_time should be 2'
  end
end
