class Referral < ApplicationRecord
  STATES = %w[accepted declined review].freeze

  belongs_to :partner

  validates :last_state, inclusion: { in: STATES }
  validates :original_response, presence: true

  def self.by_month(month, col: 'created_at')
    where("extract(month from #{col}) = ?", month)
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

  private

  def extract_values(array)
    array&.map do |hash|
      hash[:text] || hash[:email] || hash[:date] || hash[:number] ||
        hash[:boolean] || hash[:choices] || hash[:choice]
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
end
