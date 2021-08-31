module StatusColorHelper
  def status_to_bg_color
    { "planned" => "bg-red-100", "in_progress" => "bg-purple-200", "live" => "bg-blue-100" }
  end

  def status_to_border_color
    { "planned" => "border-red-100", "in_progress" => "border-purple-200", "live" => "border-blue-100" }
  end
end
