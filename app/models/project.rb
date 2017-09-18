class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :user_id, :end_date, presence: true
  validate :start_date_canot_be_in_past

  def start_date_canot_be_in_past
    if start_date < Date.today
      errors.add(:start_date, "cannot be in the past.")
    end
  end
end
