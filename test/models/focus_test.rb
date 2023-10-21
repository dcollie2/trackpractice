# frozen_string_literal: true

require 'test_helper'

class FocusTest < ActiveSupport::TestCase
  setup do
    @focus = foci(:one)
  end

  test 'should not save focus without short_description' do
    @focus.short_description = ''
    assert_not @focus.save, 'Saved the focus without a short_description'
  end

  test 'should save focus with short_description' do
    assert @focus.save, 'Saved the focus with a short_description'
  end

  test 'total practice time returns zero if there are no practices' do
    assert @focus.total_practice_time.zero?, 'total_practice_time should be zero'
  end

  test 'total practice time returns sum of minutes for all practices' do
    practice = practices(:one)
    practice.focus = @focus
    practice.save
    practice.dup.save
    assert @focus.total_practice_time == 2, 'total_practice_time should be 2'
  end
end
