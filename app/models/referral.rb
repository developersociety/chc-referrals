class Referral < ApplicationRecord
  STATES = %w[accepted declined review].freeze

  belongs_to :partner
  acts_as_sequenced scope: :partner_id

  has_many :assignments
  has_many :assignees, through: :assignments, source: :user

  has_many :reviews, dependent: :destroy

  validates :last_state, inclusion: { in: STATES }
  validates :original_response, presence: true

  def self.by_month(date, col: 'created_at')
    raise 'Argument `date` does not respond to `:strftime` method' unless date.respond_to?(:strftime)

    where("extract(month from #{col}) = ? AND extract(year from #{col}) = ?", date.month, date.year)
  end

  def self.used
    where.not(last_state: 'declined')
  end

  def emails
    response = original_response&.with_indifferent_access

    return if response.blank?

    response.dig(:form_response, :answers)&.pluck(:email)&.compact
  end

  def original_response=(hash)
    self[:last_state] = find_state(hash) if hash
    super
  end

  def response_answers
    response = original_response&.with_indifferent_access

    return if response.blank?

    questions = response.dig(:form_response, :definition, :fields)&.pluck(:title)
    answers = extract_values(response.dig(:form_response, :answers))

    questions.zip(answers).to_h if questions && answers
  end

  def response_identifier
    answers = response_answers || {}
    answers.fetch(partner.form_identifier, '-')
  end

  def to_param
    sequential_id.to_s
  end

  private

  def extract_values(array)
    array&.map do |hash|
      hash[:text] || hash[:email] || hash[:date] ||
        hash[:number] || hash[:choices] ||
        parse_choice(hash[:choice]) || parse_boolean(hash[:boolean])
    end
  end

  def find_state(hash)
    score = hash.with_indifferent_access.dig(:form_response, :calculated, :score)

    if score&.negative?
      'declined'
    else
      'review'
    end
  end

  def parse_boolean(val)
    { true => 'Yes', false => 'No' }[val]
  end

  def parse_choice(val)
    val&.fetch(:label, nil)
  end
end
