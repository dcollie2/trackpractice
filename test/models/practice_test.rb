require "test_helper"

class PracticeTest < ActiveSupport::TestCase

  setup do
    @user = users(:testy)
  end

  # test "should not save without user" do
  #   practice = Practice.new
  #   assert_not practice.save
  # end

  test "should not save without a user" do
    practice = practices(:one)
    practice.user = nil
    assert_not practice.save
  end

  test "minutes default to zero" do
    practice = Practice.new(user: @user)
    assert_equal 0, practice.minutes
  end

  test "minutes are required" do
    practice = practices(:one)
    practice.minutes = nil
    assert_not practice.save
  end

  test "minutes must be a number" do
    practice = practices(:one)
    practice.minutes = "abc"
    assert_not practice.save
  end

  test "minutes must be greater than or equal to zero" do
    practice = practices(:one)
    practice.minutes = -1
    assert_not practice.save
  end

  test "notes are optional" do
    practice = practices(:one)
    practice.notes = nil
    assert practice.save
  end

  test "date is required" do
    practice = practices(:one)
    practice.practice_date = nil
    assert_not practice.save
  end

  test "date must be a date" do
    practice = practices(:one)
    practice.practice_date = "abc"
    assert_not practice.save
  end

  # had to do this in the controller
  # test "date defaults to current date" do
  #   practice = Practice.new(user: @user)
  #   assert_equal Date.today, practice.practice_date
  # end

end
