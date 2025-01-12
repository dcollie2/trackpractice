# frozen_string_literal: true

require 'application_system_test_case'

class TimerControllerTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)
    login_as @user
  end

  test 'timer starts and updates display' do
    visit practices_path(@user)

    find_link('new-practice-button').click

    assert_changes lambda {
                     find("div.timerDisplay[data-timer-target='display']").text
                   }, from: '00 : 00 : 00 : 000', to: /\d{2} : \d{2} : \d{2} : \d{3}/ do
      click_button 'Start'
      sleep 1
    end
    # assert_selector 'input#practice_minutes[disabled]', match: :first
  end

  test 'timer pauses and enables minutes input' do
    visit practices_path(@user)

    find_link('new-practice-button').click
    click_button 'Start'
    sleep 1
    click_button 'Pause'

    assert_selector 'input#practice_minutes:not([disabled])', count: 1
    assert_no_changes -> { find("div.timerDisplay[data-timer-target='display']").text } do
      sleep 1
    end
  end

  test 'timer resumes and disables minutes input' do
    visit practices_path(@user)

    find_link('new-practice-button').click
    click_button 'Start'
    sleep 1
    click_button 'Pause'
    sleep 1

    assert_changes -> { find("div.timerDisplay[data-timer-target='display']").text } do
      click_button 'Resume'
      sleep 1
    end
    assert_selector 'input#practice_minutes[disabled]', match: :first
  end

  test 'timer resets and displays 00 : 00 : 00 : 000' do
    visit practices_path(@user)

    find_link('new-practice-button').click
    click_button 'Start'
    sleep 1
    click_button 'Reset'

    assert_selector "div.timerDisplay[data-timer-target='display']", text: '00 : 00 : 00 : 000'
    assert_selector "input[type=number][value='0']", count: 1
  end
end
