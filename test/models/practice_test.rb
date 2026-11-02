# frozen_string_literal: true

require 'test_helper'

class PracticeTest < ActiveSupport::TestCase
  # test "should not save without user" do
  #   practice = Practice.new
  #   assert_not practice.save
  # end

  # Validations
  test 'should not save without a user' do
    practice = build(:practice, user: nil)

    assert_not practice.save
  end

  test 'minutes are required' do
    practice = build(:practice, minutes: nil)

    assert_not practice.save
  end

  test 'minutes must be a number' do
    practice = build(:practice, minutes: 'abc')

    assert_not practice.save
  end

  test 'minutes must be greater than or equal to zero' do
    practice = build(:practice, minutes: -1)

    assert_not practice.save
  end

  test 'notes are optional' do
    practice = build(:practice)
    practice.notes = nil

    assert practice.save
  end

  test 'date is required' do
    practice = build(:practice, practice_date: nil)

    assert_not practice.save
  end

  test 'date must be a date' do
    practice = build(:practice, practice_date: 'abc')

    assert_not practice.save
  end

  # defaults
  test 'minutes default to zero' do
    practice = Practice.new(user: @user)

    assert_equal 0, practice.minutes
  end

  # methods
  test 'in week returns practices from the first minute of the week to the last minute in the week' do
    beginning_of_week = (Time.zone.today - 1.week).beginning_of_week
    create(:practice, practice_date: "#{beginning_of_week} 00:00:00")
    create(:practice, practice_date: "#{beginning_of_week} 23:23:59")

    assert Practice.in_week(beginning_of_week).size == 2
  end

  test 'thirty days of practices covers the 30 days ending on the given date, including that day' do
    user = create(:user)
    end_date = Time.zone.today
    create(:practice, user: user, practice_date: "#{end_date} 12:00:00", minutes: 10)
    create(:practice, user: user, practice_date: "#{end_date - 29.days} 00:00:00", minutes: 20)
    create(:practice, user: user, practice_date: "#{end_date - 30.days} 23:59:59", minutes: 30)

    days = Practice.thirty_days_of_practices(end_date, user)

    assert_equal 30, days.size
    assert_equal end_date.strftime('%a, %d %b %Y'), days.keys.last
    assert_equal 10, days[end_date.strftime('%a, %d %b %Y')]
    assert_equal 20, days[(end_date - 29.days).strftime('%a, %d %b %Y')]
    assert_equal 30, days.values.sum # the practice 30 days back is excluded
  end

  test 'show_timer? is true if the record is new' do
    test = build(:practice)

    assert test.show_timer?
  end

  test 'show_timer? is false if record has been saved' do
    test = build(:practice)
    test.save!

    assert_not test.show_timer?
  end
end
