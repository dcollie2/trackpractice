# frozen_string_literal: true

module PracticesHelper
  def day_background(date, practices)
    if practices.length.positive?
      'bg-success'
    elsif date == Date.current.in_time_zone(current_user.time_zone).to_date
      'bg-warning'
    elsif date > Date.current.in_time_zone(current_user.time_zone).to_date
      'bg-secondary'
    else
      'bg-danger'
    end
  end
end
