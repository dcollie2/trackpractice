# frozen_string_literal: true

require 'test_helper'

class PracticeTest < ActiveSupport::TestCase
  setup do
    @user = users(:testy)
  end

  # test "should not save without user" do
  #   practice = Practice.new
  #   assert_not practice.save
  # end

  test 'should not save without a user' do
    practice = practices(:one)
    practice.user = nil
    assert_not practice.save
  end

  test 'minutes default to zero' do
    practice = Practice.new(user: @user)
    assert_equal 0, practice.minutes
  end

  test 'minutes are required' do
    practice = practices(:one)
    practice.minutes = nil
    assert_not practice.save
  end

  test 'minutes must be a number' do
    practice = practices(:one)
    practice.minutes = 'abc'
    assert_not practice.save
  end

  test 'minutes must be greater than or equal to zero' do
    practice = practices(:one)
    practice.minutes = -1
    assert_not practice.save
  end

  test 'notes are optional' do
    practice = practices(:one)
    practice.notes = nil
    assert practice.save
  end

  test 'date is required' do
    practice = practices(:one)
    practice.practice_date = nil
    assert_not practice.save
  end

  test 'date must be a date' do
    practice = practices(:one)
    practice.practice_date = 'abc'
    assert_not practice.save
  end

  test 'in week returns practices from the first minute of the week to the last minute in the week' do
    beginning_of_week = (Date.today - 1.week).beginning_of_week
    practice = practices(:one)
    practice.update(practice_date: "#{beginning_of_week} 00:00:01")
    last_practice = practices(:two)
    last_practice.update(practice_date: "#{beginning_of_week.end_of_week} 23:23:59")
    assert Practice.in_week(beginning_of_week).size == 2
  end

  test 'show_timer? is true if the record is new' do
    test = Practice.new(user: @user)
    assert test.show_timer?
  end

  test 'show_timer? is false if record has been saved' do
    test = Practice.new(user: @user, practice_date: DateTime.current, minutes: 1)
    test.save!
    assert_not test.show_timer?
  end
end
