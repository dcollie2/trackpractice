require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:testy)
  end

  test "it should save" do
    assert @user.save
  end

  test "user should have practices" do
    assert @user.practices.size > 0
  end

  test "user can make their practices public" do
    @user.make_practices_public = true
    assert @user.save
    assert @user.make_practices_public
  end

  test "streak returns the correct streak count for consecutive practices" do
    user = users(:one)
    starting_date = Date.today
    practice1 = practices(:one)
    practice1.update(practice_date: starting_date)
    practice2 = practices(:two)
    practice2.update(practice_date: starting_date - 1.day)
    practice3 = practices(:three)
    practice3.update(practice_date: starting_date - 2.days)
    user.practices << [practice1, practice2, practice3]

    assert_equal 3, user.streak
  end

  test "streak returns the correct streak count with no practice today but a practice yesterday" do
    user = users(:one)
    starting_date = Date.today - 1.day
    practice1 = practices(:one)
    practice1.update(practice_date: starting_date)
    practice2 = practices(:two)
    practice2.update(practice_date: starting_date - 1.day)
    practice3 = practices(:three)
    practice3.update(practice_date: starting_date - 2.days)
    user.practices << [practice1, practice2, practice3]

    assert_equal 3, user.streak
  end

  test "streak returns 0 when there are no practices" do
    user = users(:one)

    assert_equal 0, user.streak
  end

  test "streak returns 0 when the most recent practice is not today" do
    user = users(:one)
    starting_date = Date.today.beginning_of_week
    practice = practices(:one)
    practice.update(practice_date: starting_date - 1.week)
    user.practices << practice

    assert_equal 0, user.streak
  end

  test "streak returns the correct streak count when there is a gap in the practices" do
    user = users(:one)
    starting_date = Date.today.beginning_of_week
    practice1 = practices(:one)
    practice1.update(practice_date: starting_date)
    practice2 = practices(:two)
    practice2.update(practice_date: starting_date - 2.days)
    practice3 = practices(:three)
    practice3.update(practice_date: starting_date - 3.days)
    user.practices << [practice1, practice2, practice3]

    assert_equal 1, user.streak
  end
end
