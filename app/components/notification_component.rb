# frozen_string_literal: true

class NotificationComponent < ViewComponent::Base
  def initialize(type:, message:)
    @type = type
    @message = message
    @colors = colors(type)
  end

  def colors(type)
    case type
    when "notice"
      { background: "bg-green-50", text: "text-green-700", border: "border-green-700" }
    when "alert"
      { background: "bg-red-50", text: "text-red-700", border: "border-red-700" }
    else
      raise UnknownNotificationError, "#{type} notification is unknown"
    end
  end
end
