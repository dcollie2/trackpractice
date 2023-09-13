module ApplicationHelper
  def practice_date(date, show_time=true)
    if show_time
      date.to_fs(:long)
    else
      # date with no time in format january 1, 2021
      date.strftime("%B %e, %Y")
    end
  end

  def minutes_in_words(span)
    span = 0 if span.blank?
    if span == 0
      '0'
    else
      distance_of_time_in_words(DateTime.current, DateTime.current + span.minutes)
    end
  end

  # given a number of minutes, return a string of hours and minutes
  # 90 minutes => 1 hour 30 minutes
  # 60 minutes => 1 hour
  # 30 minutes => 30 minutes
  # 0 minutes => 0 minutes
  def hours_and_minutes_in_words(span)
    span = 0 if span.blank?
    if span == 0
      '0 minutes'
    else
      hours = span / 60
      minutes = span % 60
      if hours > 0 && minutes > 0
        "#{pluralize(hours, "hour")} #{pluralize(minutes, 'minute')}"
      elsif hours > 0
        pluralize(hours, 'hour')
      else
        pluralize(minutes, 'minute')
      end
    end
  end

  def active_state(controller)
    if params[:controller] == controller
      "active"
    else
      ""
    end
  end

  # given a target and actual, return a class for the goal background with green if they are equal
  # red if actual is less than a third of the target, yellow if actual is less than two thirds of the target
  def goal_background(target, actual)
    if actual >= target
      "bg-success"
    elsif actual <= target / 3
      "bg-danger"
    else
      "bg-warning"
    end
  end

  def edit_button(item)
    link_to icon_text('bi', 'pencil-square', "Edit #{item_class_name(item)}"),
            edit_polymorphic_path(item),
            class: 'btn btn-sm btn-primary'
  end

  def delete_button(item)
    icon_button_with_confirm('bi', 'trash3', "Delete #{item_class_name(item)}",
                             item,
                             method: :delete,
                             class: 'btn btn-sm btn-outline-danger')
  end

  def item_class_name(item)
    item.class.name.blank? ? item.id : item.class.name.capitalize
  end

  def icon(type, name)
    content_tag(:i, nil, class: "#{type} bi-#{name}")
  end

  def icon_text(type, name, text)
    "#{icon(type, name)} #{text}".html_safe
  end

  # def icon_link(type, name, text, path)
  #   link_to icon_text(type, name, text), path
  # end

  # def icon_button(type, name, text, path, options={})
  #   link_to icon_text(type, name, text), path, options
  # end

  def icon_button_with_confirm(type, name, text, path, options={})
    link_to icon_text(type, name, text), path, options.merge(data: { confirm: 'Are you sure?' })
  end

  def display_field(item, field)
    if item.send(field).blank?
      return
    else
      content_tag :div do
        concat content_tag :h2, field.to_s.titleize
        concat content_tag :p, item.send(field)
      end
    end
  end

  def flash_class(name)
    case name
      when 'notice' then 'alert alert-info alert-dismissable fade show'
      when 'success' then 'alert alert-success alert-dismissable fade show'
      when 'error' then 'alert alert-danger alert-dismissable fade show'
      when 'alert' then 'alert alert-danger alert-dismissable fade show'
      else
        'alert alert-primary alert-dismissable fade show'
    end
  end

  # Exlude these messages from appearing
  def flash_blacklist(name)
    %w[timedout].include?(name)
  end
end
