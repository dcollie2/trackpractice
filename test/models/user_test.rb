# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'it should save' do
    assert @user.save
  end

  test 'user can make their practices public' do
    @user.update(make_practices_public: true)

    assert @user.make_practices_public
  end

  # TODO: the test is correct but you cannot work backwards from starting date
  # TODO: fix the logic so it sees an asynctronous streak
  # TODO: write this test backwards to catch the failure
  test 'streak returns the correct streak count for consecutive practices' do
    create(:practice, practice_date: Time.zone.now - 2.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 1.days, user: @user)
    create(:practice, practice_date: Time.zone.now, user: @user)
    @user.reload

    assert_equal 3, @user.streak
  end

  test 'streak returns the correct streak count with no practice today but a practice yesterday' do
    create(:practice, practice_date: Time.zone.now - 3.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 2.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 1.days, user: @user)
    @user.reload

    assert_equal 3, @user.streak
  end

  test 'streak returns 0 when there are no practices' do
    assert_equal 0, @user.streak
  end

  test 'streak returns 0 when the most recent practice is not within two days' do
    create(:practice, practice_date: Time.zone.now - 4.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 3.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 2.days, user: @user)
    @user.reload

    assert_equal 0, @user.streak
  end

  test 'streak 0 when there is a gap in the practices' do
    create(:practice, practice_date: Time.zone.now - 4.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 2.days, user: @user)
    create(:practice, practice_date: Time.zone.now - 1.days, user: @user)
    @user.reload

    assert_equal 0, @user.streak
  end
end
