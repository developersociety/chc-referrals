class Review < ApplicationRecord
  STATES = %w[accepted declined].freeze

  belongs_to :referral
  belongs_to :user

  acts_as_sequenced scope: :referral_id, column: :position

  validates :state, inclusion: { in: STATES }

  after_create { referral.update(last_state: state) }
end
