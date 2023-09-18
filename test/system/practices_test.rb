require "application_system_test_case"

class PracticesTest < ApplicationSystemTestCase
  setup do
    @practice = practices(:one)
    @practice.update(practice_date: DateTime.current)
    login_as @practice.user
  end

  test "visiting the index" do
    visit practices_url
    assert_selector "h1", text: "Week of #{DateTime.current.beginning_of_week.strftime('%B %-d, %Y')}"
  end

  test "should create practice" do
    visit practices_url
    click_on "New practice"

    fill_in "Minutes", with: '30'
    fill_in "Notes", with: 'these are notes'
    fill_in "Practice date", with: DateTime.current.strftime('%d/%m/%Y')
    click_on "Create Practice"
    assert_text "Practice was successfully created"
  end

  test "should update Practice" do
    @practice.save
    visit practices_url
    click_on "Edit", match: :first

    fill_in "Minutes", with: 5
    fill_in "Notes", with: @practice.notes

    click_on "Update Practice"

    assert_text "Practice was successfully updated"
  end

  test "should destroy Practice" do
    visit practices_url
    accept_alert "Are you sure you want to delete this practice?" do
      click_on "Delete", match: :first
    end


    assert_text "Practice was successfully destroyed"

  end
end
