# frozen_string_literal: true

require 'test_helper'

class PracticePartialTest < ActionView::TestCase
  include ActionView::TestCase::Behavior
  include ApplicationHelper

  def setup
    @user = create(:user)
    @practice = create(:practice, user: @user)
    @focus = create(:focus, user: @user)
    @song = create(:song, user: @user)
  end

  test 'displays the practice date' do
    render partial: 'practices/practice', locals: { practice: @practice }

    assert_select 'h5', text: practice_date(@practice.practice_date)
  end

  test 'displays the practice minutes in words' do
    render partial: 'practices/practice', locals: { practice: @practice }

    assert_select 'h5', text: minutes_in_words(@practice.minutes)
  end

  test 'displays the focus short description' do
    @practice.focus = @focus
    render partial: 'practices/practice', locals: { practice: @practice }

    assert_select 'h2', text: @focus.short_description
  end

  test 'displays the song title' do
    @practice.song = @song
    render partial: 'practices/practice', locals: { practice: @practice }

    assert_select 'h2', text: @song.title
  end

  test 'displays the notes' do
    @practice.update(notes: 'Some notes.')
    render partial: 'practices/practice', locals: { practice: @practice }

    assert_select 'p', text: @practice.notes
  end

  test 'displays the edit and delete buttons' do
    render partial: 'practices/practice', locals: { practice: @practice }

    assert_select 'a', text: 'Edit'
    assert_select 'button', text: 'Delete'
  end
end
