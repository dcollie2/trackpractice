module ApplicationHelper
  def practice_date(date)
    date.to_fs(:long)
  end

  def minutes_in_words(span)
    span = 0 if span.blank?
    distance_of_time_in_words(DateTime.now, DateTime.now + span.minutes)
  end

end
