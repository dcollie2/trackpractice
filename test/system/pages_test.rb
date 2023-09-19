require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  setup do
    @page = pages(:one)
    login_as users(:admin)
  end

  test "visiting the index" do
    visit pages_url
    assert_selector "h1", text: "Pages"
  end

  test 'visiting home redirects logged in user to practices' do
    visit root_url
    assert_selector "h1", text: "Week of #{DateTime.current.beginning_of_week.strftime('%B %-d, %Y')}"
  end

  test 'visiting home shows non-logged-in user the home page' do
    logout
    visit root_url
    assert_text 'Login or Create Account'
  end

  test "should create page" do
    visit pages_url
    click_on "New page"

    fill_in "Contents", with: @page.contents
    fill_in "Name", with: @page.name
    click_on "Create Page"

    assert_text "Page was successfully created"
    click_on "Back"
  end

  test "should update Page" do
    visit page_url(@page)
    click_on "Edit this page", match: :first

    fill_in "Contents", with: @page.contents
    fill_in "Name", with: @page.name
    click_on "Update Page"

    assert_text "Page was successfully updated"
    click_on "Back"
  end

  test "should destroy Page" do
    visit page_url(@page)
    click_on "Destroy this page", match: :first

    assert_text "Page was successfully destroyed"
  end
end
