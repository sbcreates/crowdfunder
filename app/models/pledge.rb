class Pledge < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :dollar_amount, presence: true
  validates :user, presence: true
  validate :owner_cannot_back

  def owner_cannot_back
    if self.user == project.user
      errors.add(:owner, "cannot back own project")
    end
  end

end
