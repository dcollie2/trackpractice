require "test_helper"

class FociControllerTest < ActionDispatch::IntegrationTest
  setup do
    @focus = foci(:one)
    @user = @focus.user
  end

  test "should get index" do
    sign_in @user
    get foci_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_focus_url
    assert_response :success
  end

  test "should create focus" do
    sign_in @user
    assert_difference("Focus.count") do
      post foci_url, params: { focus: { short_description: @focus.short_description, user_id: @focus.user_id } }
    end

    assert_redirected_to foci_url
  end

  test "should show focus" do
    sign_in @user
    get focus_url(@focus)
    assert_response :success
  end

  test "should get edit" do
    sign_in @user
    get edit_focus_url(@focus)
    assert_response :success
  end

  test "should update focus" do
    sign_in @user
    patch focus_url(@focus), params: { focus: { short_description: @focus.short_description, user_id: @focus.user_id } }
    assert_redirected_to foci_url
  end

  test "should destroy focus" do
    sign_in @user
    assert_difference("Focus.count", -1) do
      delete focus_url(@focus)
    end

    assert_redirected_to foci_url
  end
end
