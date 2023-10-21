# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class FociTest < ApplicationSystemTestCase
  setup do
    @focus = foci(:one)
    login_as @focus.user
  end

  test 'visiting the index' do
    visit foci_url
    assert_selector 'h1', text: 'Foci'
  end

  test 'should create focus' do
    visit foci_url
    click_on 'New Focus'

    fill_in 'Short description', with: @focus.short_description
    click_on 'Update Focus'

    assert_text 'Focus was successfully created'
  end

  test 'should update Focus' do
    visit focus_url(@focus)
    click_on 'Edit Focus', match: :first

    fill_in 'Short description', with: @focus.short_description
    click_on 'Update Focus'

    assert_text 'Focus was successfully updated'
  end

  test 'should destroy Focus' do
    visit focus_url(@focus)
    accept_alert 'Are you sure?' do
      click_on 'Delete Focus', match: :first
    end

    assert_text 'Focus was successfully destroyed'
  end
end
