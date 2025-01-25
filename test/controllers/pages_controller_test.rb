# frozen_string_literal: true

require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @page = create(:page)
    @user = create(:user)
  end

  test 'should get index' do
    sign_in @user
    get pages_url
    assert_response :success
  end

  test 'should get new' do
    sign_in @user
    get new_page_url
    assert_response :success
  end

  test 'should create page' do
    sign_in @user

    assert_difference('Page.count') do
      post pages_url, params: { page: { contents: @page.contents, name: @page.name } }
    end

    assert_redirected_to page_url(Page.last)
  end

  test 'should show page' do
    sign_in @user
    get page_url(@page)
    assert_response :success
  end

  test 'should get edit' do
    sign_in @user

    get edit_page_url(@page)
    assert_response :success
  end

  test 'should update page' do
    sign_in @user
    patch page_url(@page), params: { page: { contents: @page.contents, name: @page.name } }
    assert_redirected_to page_url(@page)
  end

  test 'should destroy page' do
    sign_in @user

    assert_difference('Page.count', -1) do
      delete page_url(@page)
    end

    assert_redirected_to pages_url
  end
end
