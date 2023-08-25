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

end
