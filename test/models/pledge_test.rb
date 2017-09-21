require_relative '../test_helper'
require "pry"

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do
    pledge = create(:pledge, project: create(:project))

    assert pledge.valid?
    assert pledge.persisted?
  end

  test 'owner cannot back own project' do
    owner = create(:user)
    project = build(:project, user: owner)

    pledge = build(:pledge, user: owner, project: project)

    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

end
