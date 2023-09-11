require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    @non_admin_user = users(:one)
    sign_in @non_admin_user

    @public_user = users(:two)
    @public_user.update(make_practices_public: true)

    @private_user = users(:three)
    @private_user.update(make_practices_public: false)

    @admin = users(:admin)
  end

  test 'if not admin, should only see public users and self' do
    visit users_url
    assert_text 'test1@test.test'
    assert_text 'test2@test.test'
    assert_no_text 'test3@test.test'
  end

  test "non-admins who try to edit another user's profile will see their own edit page"

  test "user emails should link to their profile page" do
    visit users_url
    click_on @public_user.email
    assert_text @public_user.email
    assert_text "Practices"
  end

end
