require 'test_helper'
require 'pry'

class UserTest < ActiveSupport::TestCase

  test "email must be unique" do
    user = User.create(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "12345678")
    user2 = User.new(email: "bettymaker@gmail.com", password: "00000000", password_confirmation: "00000000")
    refute user2.valid?
  end

  test "user must include password_confirmation on create" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678")
    refute user.valid?
  end

  test "password must match confirmation" do
    user = User.new(email: "bettymaker@gmail.com", password: "12345678", password_confirmation: "87654321")
    refute user.valid?
  end

  test "password must be at least 8 characters long" do
    user = User.new(email: "bettymaker@gmail.com", password: "1234", password_confirmation: "1234")
    refute user.valid?
  end

  # test "user should see all projects they have backed" do
  #   pledge = build(:pledge)
  #   pledge.save
  #   user = User.find_by(id: pledge.user_id)
  #   outcome = user.projects
  #   expect = Project.find_by(id: pledge.project_id)
  #
  #
  #   assert_equal(outcome, expect)
  # end

end
