require "test_helper"
require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @non_admin_user = users(:one)

    @public_user = users(:two)
    @public_user.update!(make_practices_public: true)

    @private_user = users(:three)
    @private_user.update!(make_practices_public: false)

    @admin = users(:admin)
  end

  test 'if not admin, should only see public users and self' do
    sign_in @non_admin_user
    visit users_url
    assert_text 'test1@test.test'
    assert_text 'test2@test.test'
    assert_no_text 'test3@test.test'
  end

  test 'if admin, should see all users' do
    sign_in @admin
    visit users_url
    assert_text 'test1@test.test'
    assert_text 'test2@test.test'
    assert_text 'test3@test.test'
  end

  test 'admins can edit other users' do
    sign_in @admin
    visit users_url
    click_on 'Edit', match: :first
    # select a time zone
    select 'American Samoa', from: 'Time zone'
    click_on 'Update User'
    assert_text 'User was successfully updated'
  end

  test "non-admins who try to edit another user's profile will see their own edit page" do
    sign_in @non_admin_user
    visit edit_user_url(@private_user)
    assert_text @non_admin_user.email
  end

  test "non-admins visiting the user list should be able to click on a public user's email and see their practices" do
    sign_in @non_admin_user
    visit users_url
    click_on @public_user.email
    assert_text @public_user.email
    assert_text "Viewing #{@public_user.email}'s practices"
  end

  test "admins can destroy users" do
    sign_in @admin
    visit users_url
    accept_alert "Are you sure?" do
      click_on "Delete User", match: :first
    end

    assert_text "User was successfully destroyed"
  end

  test "users can update their own profile" do
    sign_in @non_admin_user

    visit edit_user_path(@non_admin_user)

    fill_in 'Email', with: 'newemail@example.com'
    click_on 'Update'

    assert_text 'User was successfuly updated'
    assert_equal 'newemail@example.com', @user.reload.email

  end

  test "non-admins do not see deletion button" do
    sign_in @non_admin_user
    visit users_url
    assert_no_text "Delete User"
  end

  test "non-admins cannot see non-public users' practices"


end
