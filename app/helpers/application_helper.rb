module ApplicationHelper
  def show_flash
    [:notice, :error, :warning, :done].collect do |key|
     unless flash[key].blank?
       case key.to_s
        when "error"
          content_tag(:div, flash[key], :class => 'alert alert-error')
        when "notice"
          haml_tag(:div, flash[key], :class => "alert alert-info")
        when "done"
          content_tag(:div, flash[key], :class => "alert alert-success")
        when "warning"
          content_tag(:div, flash[key], :class => "alert")
        end
     end
    end.join
  end
end
