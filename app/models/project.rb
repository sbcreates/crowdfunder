class Project < ActiveRecord::Base
  has_many :rewards
  has_many :pledges
  has_many :users, through: :pledges # backers
  belongs_to :user # project owner

  validates :title, :description, :goal, :start_date, :user_id, :end_date, presence: true
  validate :start_date_canot_be_in_past
  validate :end_date_must_follow_start_date
  validates :goal, :numericality => { :greater_than => 0 }

  def start_date_canot_be_in_past
    if start_date < Date.today
      errors.add(:start_date, "cannot be in the past.")
    end
  end

  def end_date_must_follow_start_date
    if end_date < start_date
      errors.add(:end_date, "must be after start date.")
    end
  end
end
