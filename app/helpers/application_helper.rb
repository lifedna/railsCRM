module ApplicationHelper
  def show_flash
    [:notice, :error, :warning, :done].collect do |key|
      content_tag(:div, flash[key], :class => "msg #{key}") unless flash[key].blank?
    end.join
  end
end
