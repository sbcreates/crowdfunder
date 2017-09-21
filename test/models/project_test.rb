require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'valid project can be created' do
    owner = new_user
    owner.save
    project = new_project
    project.user = owner
    project.save
    assert project.valid?
    assert project.persisted?
    assert project.user
  end

  test 'project is invalid without owner' do
    project = new_project
    project.user = nil
    project.save
    assert project.invalid?, 'Project should not save without owner.'
  end

  test 'project must start in future' do

    project = new_project
    user =  new_user
    user.save
    project.user = user
    project.start_date = Date.today - 1.week
    project.save

    assert project.invalid?, 'Project should not be able start in the past.'

  end

  test "project must end after start date" do
    project = new_project
    user =  new_user
    user.save
    project.user = user
    project.start_date = Date.today
    project.end_date = Date.today - 1.week
    project.save

    assert project.invalid?, 'Project should end after start date.'
  end

  test "project goal must be positive number" do
    project = new_project
    user =  new_user
    user.save
    project.user = user

    project.goal = 0
    project.save

    assert project.invalid?, "Project goal must be a positive number"


  end

  def new_project
    Project.new(
      title:       'Cool new boardgame',
      description: 'Trade sheep',
      start_date:  Date.today,
      end_date:    Date.today + 1.month,
      goal:        50000
    )
  end

  def new_user
    User.new(
      first_name:            'Sally',
      last_name:             'Lowenthal',
      email:                 'sally@example.com',
      password:              'passpass',
      password_confirmation: 'passpass'
    )
  end

  test "User can see total pledge amount for project" do

    project = create(:project)
    pledge = create(:pledge, user: create(:user), project: project, dollar_amount: 20)
    pledge = create(:pledge, user: create(:user), project: project, dollar_amount: 11)
    pledge = create(:pledge, user: create(:user), project: project, dollar_amount: 12)
    pledge = create(:pledge, user: create(:user), project: project, dollar_amount: 13)
    pledge = create(:pledge, user: create(:user), project: project, dollar_amount: 20)

    sum = 20 + 11 + 12 + 13 + 20

    assert_equal sum, project.pledges.pluck(:dollar_amount).sum
  end


end
