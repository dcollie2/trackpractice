require "application_system_test_case"

class FociTest < ApplicationSystemTestCase
  setup do
    @focus = foci(:one)
  end

  test "visiting the index" do
    visit foci_url
    assert_selector "h1", text: "Foci"
  end

  test "should create focus" do
    visit foci_url
    click_on "New focus"

    fill_in "Short description", with: @focus.short_description
    fill_in "User", with: @focus.user_id
    click_on "Create Focus"

    assert_text "Focus was successfully created"
    click_on "Back"
  end

  test "should update Focus" do
    visit focus_url(@focus)
    click_on "Edit this focus", match: :first

    fill_in "Short description", with: @focus.short_description
    fill_in "User", with: @focus.user_id
    click_on "Update Focus"

    assert_text "Focus was successfully updated"
    click_on "Back"
  end

  test "should destroy Focus" do
    visit focus_url(@focus)
    click_on "Destroy this focus", match: :first

    assert_text "Focus was successfully destroyed"
  end
end
