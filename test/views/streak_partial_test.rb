# frozen_string_literal: true

require 'test_helper'

class StreakPartialTest < ActionView::TestCase
  include ActionView::TestCase::Behavior
  include ApplicationHelper

  def setup
    @user = create(:user)
  end

  # test 'displays the practice date' do
  #   render partial: 'practices/streak', locals: { user: @practice.user }

  #   # assert that the text is in the rendered output in a div with the id of user-streak
  #   assert_select 'div#user-streak', text: "You're on a 4 day streak!"
  # end

  test 'streak partial is displayed when user streak is greater than 2' do
    @user.stub :streak, 3 do
      render partial: 'practices/streak', locals: { user: @user }

      assert_select 'div#user-streak', count: 1
      assert_select 'div.badge.bg-primary', text: "You're on a 3 day streak!"
    end
  end

  test 'streak partial is not displayed when user streak is less than or equal to 2' do
    @user.stub :streak, 2 do
      render partial: 'practices/streak', locals: { user: @user }

      assert_select 'div#user-streak', count: 0
      # assert_select 'div.badge.bg-primary', text: "You're on a 3 day streak!"
    end
  end
end
