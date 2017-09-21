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

  test "user should see all projects they have backed" do

    owner = create(:user, email: "andy@gmail.com")

    project1 = create(:project, user: owner)
    project2 = create(:project, user: owner)

    pledger = create(:user)

    pledge = create(:pledge, user: pledger, project: project1)
    pledge2 = create(:pledge, user: pledger, project: project2)

    array_of_projects = pledger.pledges.all.to_a.map { |each_pledge| each_pledge.project}

    assert_equal(array_of_projects, [project1, project2])
  end

  test "user should see total amount they have pledged" do

    owner = create(:user, email: "andy@gmail.com")

    project1 = create(:project, user: owner)
    project2 = create(:project, user: owner)

    pledger = create(:user)

    pledge = create(:pledge, user: pledger, project: project1)
    pledge2 = create(:pledge, user: pledger, project: project2)

    pledge_sum = pledger.pledges.pluck(:dollar_amount).sum

    assert_equal(pledge_sum, (pledge.dollar_amount + pledge2.dollar_amount))
  end

  test "user should see all projects they own" do

    owner = create(:user, email: "andy@gmail.com")

    project1 = create(:project, user: owner)
    project2 = create(:project, user: owner)

    array_of_projects = owner.projects.all.to_a

    assert_equal(array_of_projects,  [project1, project2] )
  end

  test "user should see project owner when visiting project page" do
    project = create(:project)

    assert(project.user)
  end



end
