# frozen_string_literal: true

require 'test_helper'

class PracticesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @practice = create(:practice, user: @user)
  end

  test 'should get index' do
    sign_in @user
    get practices_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_practice_url
    assert_response :success
  end

  test 'should create practice' do
    sign_in @user
    assert_difference('Practice.count') do
      post practices_url,
           params: { practice: { minutes: @practice.minutes, notes: @practice.notes,
                                 practice_date: @practice.practice_date } }
    end

    assert_redirected_to practices_url
  end

  # test "create action sets flash warning and renders turbo_stream with form partial on invalid input" do
  #   post :create, params: { practice: { name: "" } }, xhr: true

  #   assert_equal "Could not create practice.", flash[:warning]
  #   assert_response :unprocessable_entity
  #   assert_match /<form class="new_practice" id="new_practice" action="\/practices" accept-charset="UTF-8" data-remote="true" method="post">/m, @response.body
  # end

  test 'should set focus user if that user is public' do
    another_user = create(:user, make_practices_public: true)
    sign_in @user
    get practices_url, params: { user_id: another_user.id }
    assert_response :success
    assert response.body.include?(another_user.email)
  end

  test 'should not set focus user if that user is not public' do
    another_user = create(:user, make_practices_public: false)
    sign_in @user
    get practices_url, params: { user_id: another_user.id }
    assert_response :redirect
  end

  test 'set_current_week sets @current_week to current week when params[:week] is not present' do
    sign_in @user
    get practices_url

    assert_equal Date.current.beginning_of_week, assigns(:current_week)
  end

  test 'set_current_week sets @current_week to current week when params[:week] is invalid' do
    sign_in @user
    get practices_url, params: { week: 'invalid date' }

    assert_equal Date.current.beginning_of_week, assigns(:current_week)
  end

  test 'set_current_week sets @current_week to params[:week] when it is a valid date' do
    sign_in @user
    get practices_url, params: { week: Date.current.to_s }

    assert_equal Date.current.beginning_of_week, assigns(:current_week)
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
