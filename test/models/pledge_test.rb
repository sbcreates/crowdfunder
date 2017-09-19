require_relative '../test_helper'
require "pry"

class PledgeTest < ActiveSupport::TestCase

  test 'A pledge can be created' do
# binding.pry

    pledge = create(:pledge, project: create(:project))

    assert pledge.valid?
    assert pledge.persisted?
  end

  test 'owner cannot back own project' do
    owner = create(:user)
    project = build(:project)
    project.user = owner
    project.save
    pledge = build(:pledge)
    pledge.user = owner
    pledge.save
    assert pledge.invalid?, 'Owner should not be able to pledge towards own project'
  end

end
