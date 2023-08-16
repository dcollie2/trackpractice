require "test_helper"

class PracticesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @practice = practices(:one)
    @user = users(:testy)
  end

  test "should get index" do
    sign_in @user
    get practices_url
    assert_response :success
  end

  test "should get new" do
    sign_in @user
    get new_practice_url
    assert_response :success
  end

  test "should create practice" do
    sign_in @user
    assert_difference("Practice.count") do
      post practices_url, params: { practice: { minutes: @practice.minutes, notes: @practice.notes, practice_date: @practice.practice_date } }
    end

    assert_redirected_to practices_url
  end

  # not really, since we're going single page
  # test "should show practice" do
  #   sign_in @user
  #   get practice_url(@practice)
  #   assert_response :success
  # end

  # TODO: How should I test this with Turbo?
  # test "should get edit" do
  #   sign_in @user
  #   get edit_practice_url(@practice)
  #   assert_response :success
  # end

  # test "should update practice" do
  #   sign_in @user
  #   patch practice_url(@practice), params: { practice: { minutes: @practice.minutes, notes: @practice.notes, practice_date: @practice.practice_date } }
  #   assert_redirected_to practices_url
  # end
  #
  # test "should destroy practice" do
  #   sign_in @user
  #   assert_difference("Practice.count", -1) do
  #     delete practice_url(@practice)
  #   end
  #
  #   assert_redirected_to practices_url
  # end
end
