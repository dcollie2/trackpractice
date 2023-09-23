require 'test_helper'

class StreakPartialTest < ActionView::TestCase
  include ActionView::TestCase::Behavior
  include ApplicationHelper

  def setup
    @practice = practices(:one)
    @practice.update(practice_date: DateTime.current)
    @practice_2 = practices(:one)
    @practice_2.update(practice_date: @practice.practice_date - 1.day)
    @practice_3 = practices(:one)
    @practice_3.update(practice_date: @practice.practice_date - 2.days)
    @practice_4 = practices(:one)
    @practice_4.update(practice_date: @practice.practice_date - 3.days)
  end

  test 'displays the practice date' do
    render partial: 'practices/streak', locals: { user: @practice.user }

    # assert that the text is in the rendered output in a div with the id of user-streak
    assert_select 'div#user-streak', text: "You're on a 4 day streak!"
  end


end
