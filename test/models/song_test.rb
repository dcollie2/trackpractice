require "test_helper"

class SongTest < ActiveSupport::TestCase
  setup do
    @song = songs(:one)
  end
  test "should not save song without title" do
    @song.title = ''
    assert_not @song.save, "Saved the song without a title"
  end

  test "should save song with title" do
    assert @song.save, "Saved the song with a title"
  end

  test "total practice time returns zero if there are no practices" do
    assert @song.total_practice_time == 0, "total_practice_time should be zero"
  end

  test "total practice time returns sum of minutes for all practices" do
    practice = practices(:one)
    practice.song = @song
    practice.save
    practice2 = practice.dup.save
    assert @song.total_practice_time == 2, "total_practice_time should be 2"
  end
end
