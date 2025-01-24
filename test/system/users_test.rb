# frozen_string_literal: true

require 'test_helper'
require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = create(:user)

    @public_user = create(:user, :public)

    @admin_user = create(:user, :admin)
  end

  test 'if not admin, should only see public users and self' do
    sign_in @user
    visit users_url
    assert_text @user.email
    assert_text @public_user.email
    assert_no_text @admin_user.email
  end

  test 'if admin, should see all users' do
    sign_in @admin_user
    visit users_url
    assert_text @user.email
    assert_text @public_user.email
    assert_text @admin_user.email
  end

  test 'admins can edit other users' do
    sign_in @admin_user
    visit users_url
    click_on 'Edit', match: :first
    # select a time zone
    select 'American Samoa', from: 'Time zone'
    click_on 'Update User'
    assert_text 'User was successfully updated'
  end

  test 'non-admins who try to edit another user are told they cannot view that user' do
    sign_in @public_user
    visit edit_user_url(@user)
    assert_text 'You cannot view that user'
  end

  # test "non-admins visiting the user list should be able to click on a public user's email and see their practices" # do
  #   sign_in @user
  #   visit users_url
  #   click_on @public_user.email
  #   assert_text @public_user.email
  #   assert_text "Viewing #{@public_user.email}'s practices"
  # end

  test 'admins can destroy users' do
    sign_in @admin_user
    visit users_url
    accept_alert 'Are you sure?' do
      click_on 'Delete User', match: :first
    end

    assert_text 'User was successfully destroyed'
  end

  test 'users can update their own profile' do
    sign_in @user

    visit edit_user_path(@user)

    select 'American Samoa', from: 'Time zone'
    click_on 'Update User'
    sleep 1

    assert_text 'User was successfully updated'
  end

  test 'non-admins do not see deletion button' do
    sign_in @user
    visit users_url
    assert_no_text 'Delete User'
  end
end
