module ApplicationHelper


  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end


  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "NoTeLimites.com"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end
end


def flash_class(level)
  case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-danger"
    when :alert then "alert alert-warning"
  end
end


def current_user?(user)
  user == current_user
end

