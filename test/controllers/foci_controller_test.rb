require "test_helper"

class FociControllerTest < ActionDispatch::IntegrationTest
  setup do
    @focus = foci(:one)
  end

  test "should get index" do
    get foci_url
    assert_response :success
  end

  test "should get new" do
    get new_focus_url
    assert_response :success
  end

  test "should create focus" do
    assert_difference("Focus.count") do
      post foci_url, params: { focus: { short_description: @focus.short_description, user_id: @focus.user_id } }
    end

    assert_redirected_to focus_url(Focus.last)
  end

  test "should show focus" do
    get focus_url(@focus)
    assert_response :success
  end

  test "should get edit" do
    get edit_focus_url(@focus)
    assert_response :success
  end

  test "should update focus" do
    patch focus_url(@focus), params: { focus: { short_description: @focus.short_description, user_id: @focus.user_id } }
    assert_redirected_to focus_url(@focus)
  end

  test "should destroy focus" do
    assert_difference("Focus.count", -1) do
      delete focus_url(@focus)
    end

    assert_redirected_to foci_url
  end
end
