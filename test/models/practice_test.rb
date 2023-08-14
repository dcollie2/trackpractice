require "test_helper"

class PracticeTest < ActiveSupport::TestCase

  setup do
    @user =User.create()
  end
  # test "the truth" do
  #   assert true
  # end
  # test "should not save without user" do
  #   practice = Practice.new
  #   assert_not practice.save
  # end

  test "should save with a user" do
    practice = Practice.new(user: @user)
    assert practice.save
  end

end
