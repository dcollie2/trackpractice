require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:testy)
  end

  test "it should save" do
    assert @user.save
  end

  test "user should have practices" do
    assert @user.practices.size > 0
  end

  test "user can make their practices public" do
    @user.make_practices_public = true
    assert @user.save
    assert @user.make_practices_public
  end

end
