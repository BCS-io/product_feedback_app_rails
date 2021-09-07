# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:, message:)
    @type = type
    @message = message
    @colors = colors
  end

  def colors
    case @type
    when "notice"
      "bg-green-500 text-white border-green-700"
    when "alert"
      "bg-red-100 text-black border-red-200"
    else
      raise UnknownNotificationError, "#{@type} notification is unknown"
    end
  end
end
