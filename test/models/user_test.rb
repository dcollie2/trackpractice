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
end
