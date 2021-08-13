# frozen_string_literal: true

class UserLoginComponent < ViewComponent::Base
  attr_reader :current_user

  def initialize(current_user:, user_signed_in:)
    @current_user = current_user
    @user_signed_in = user_signed_in
  end

  private

  def user_signed_in?
    @user_signed_in
  end
end
