ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  tags = if /^<label/.match?(html_tag)
           html_tag
         else
           "<div class=\"field_with_errors\">#{html_tag}</div>"
         end

  tags.html_safe
end
