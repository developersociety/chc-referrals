ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  def assert_error(key, msg, subject: @subject)
    assert_includes(subject.errors[key], msg)
  end

  def assert_present(key, msg: "can't be blank", subject: @subject, value: nil)
    subject.send("#{key}=", value)
    subject.valid?
    assert_error(key, msg)
  end

  def assert_unique(key, msg: 'has already been taken', subject: @subject)
    subject.save!
    dup = subject.dup
    dup.valid?
    assert_error(key, msg, subject: dup)
  end
end
