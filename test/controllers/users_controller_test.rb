# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)

    @public_user = create(:user, :public)
  end

  test 'should get index if logged in' do
    sign_in @user
    get users_url
    assert_response :success
  end

  test 'should be redirected if not logged in' do
    get users_url
    assert_redirected_to new_user_session_url
  end

  test 'should get show' do
    sign_in @user
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    sign_in @user
    get edit_user_url(@user)
    assert_response :success
  end

  test 'user should be able to update their own profile' do
    sign_in @user
    get edit_user_url(@user)
    assert_response :success
    patch user_url(@user),
          params: { user: { email: @user.email,
                            make_practices_public: @user.make_practices_public } }
    assert_redirected_to users_url
  end
end
