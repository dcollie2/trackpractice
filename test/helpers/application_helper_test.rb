# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'hours_and_minutes_in_words returns 0 minutes for 0 span' do
    assert_equal '0 minutes', hours_and_minutes_in_words(0)
  end

  test 'hours_and_minutes_in_words returns minutes for span less than 60' do
    assert_equal '30 minutes', hours_and_minutes_in_words(30)
  end

  test 'hours_and_minutes_in_words returns hours for span greater than or equal to 60' do
    assert_equal '1 hour', hours_and_minutes_in_words(60)
    assert_equal '2 hours', hours_and_minutes_in_words(120)
  end

  test 'hours_and_minutes_in_words returns hours and minutes for span greater than or equal to 60' do
    assert_equal '1 hour 1 minute', hours_and_minutes_in_words(61)
    assert_equal '2 hours 15 minutes', hours_and_minutes_in_words(135)
  end

  test 'goal_background returns bg-success for actual >= target' do
    assert_equal 'bg-success', goal_background(100, 100)
    assert_equal 'bg-success', goal_background(100, 200)
  end

  test 'goal_background returns bg-danger for actual <= target / 3' do
    assert_equal 'bg-danger', goal_background(100, 30)
    assert_equal 'bg-danger', goal_background(100, 0)
  end

  test 'goal_background returns bg-warning for actual < target and actual > target / 3' do
    assert_equal 'bg-warning', goal_background(100, 50)
    assert_equal 'bg-warning', goal_background(100, 80)
  end

  test 'flash_class returns alert-success for notice' do
    assert_equal 'alert alert-info alert-dismissable fade show', flash_class('notice')
  end

  test 'flash_class returns alert-warning for success' do
    assert_equal 'alert alert-success alert-dismissable fade show', flash_class('success')
  end

  test 'flash_class returns alert-danger for error and alert' do
    assert_equal flash_class('error'), 'alert alert-danger alert-dismissable fade show'
    assert_equal 'alert alert-danger alert-dismissable fade show', flash_class('alert')
  end

  test 'flash_class returns alert-primary for info' do
    assert_equal 'alert alert-primary alert-dismissable fade show', flash_class('info')
  end
end
