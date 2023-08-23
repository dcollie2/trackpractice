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
end
