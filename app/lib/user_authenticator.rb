# frozen_string_literal: true

class UserAuthenticator
  class AuthenticatorError < StandardError; end

  attr_reader :user

  def initialize(code); end

  def perform
    raise AuthenticatorError
  end
end
