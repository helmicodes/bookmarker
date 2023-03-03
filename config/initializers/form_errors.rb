# Inline form-field error messages

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /type="hidden"/ || html_tag =~ /<label/
    html_tag
  else
    %{<div class="field-with-errors">
        #{html_tag}
        <span class="error">
          #{[instance.error_message].flatten.first}
        </span>
      </div>
    }.html_safe
  end
end
