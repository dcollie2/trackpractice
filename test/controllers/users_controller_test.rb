require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @non_admin_user = users(:one)
    sign_in @non_admin_user

    @public_user = users(:two)
    @public_user.make_practices_public = true

    @private_user = users(:three)
    @private_user.make_practices_public = false

    @admin = users(:admin)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test 'should not get index if not logged in' do
    sign_out @non_admin_user
    get users_url
    assert_redirected_to new_user_session_url
  end

  test "should get show" do
    get user_url(@non_admin_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@non_admin_user)
    assert_response :success
  end

  test "user should be able to update their own profile" do
    get edit_user_url(@non_admin_user)
    assert_response :success
    patch user_url(@non_admin_user), params: { user: { email: @non_admin_user.email, make_practices_public: @non_admin_user.make_practices_public } }
    assert_redirected_to users_url
  end
end
