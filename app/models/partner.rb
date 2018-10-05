class Partner < ApplicationRecord
  has_many :referrals

  has_secure_token :webhook_token

  validates :name, :slug, presence: true, uniqueness: true
  validates :accepting_referrals, inclusion: { in: [true, false] }
  validates :form_url, presence: true, format: {
    with: %r{https?://},
    message: 'must begin with http:// or https://'
  }
  validates :max_monthly_referrals, presence: true, numericality: {
    greater_than_or_equal_to: 0
  }

  def self.active
    where(accepting_referrals: true)
  end

  def can_accept_referrals?
    referrals.used.by_month(Time.zone.now.month).size < max_monthly_referrals
  end

  def name=(str)
    self[:slug] = str&.parameterize
    super
  end

  def to_param
    slug
  end
end
