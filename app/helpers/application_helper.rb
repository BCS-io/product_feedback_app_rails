module ApplicationHelper
  def show_errors(object, field_name)
    object.errors.messages[field_name].join(", ") if object.errors.any? && object.errors.messages[field_name].present?
  end
end
