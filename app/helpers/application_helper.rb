module ApplicationHelper
  def flash_class_for(type)
    case type
    when :notice then "alert-success"
    when :error  then "alert-error"
    when :alert  then "alert-warning"
    end
  end
end
