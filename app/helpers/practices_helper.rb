module PracticesHelper

  def day_background(date, practices)
    if practices.length > 0
      "bg-success"
    elsif date == Date.today
      "bg-warning"
    elsif date > Date.today
      "bg-secondary"
    else
      "bg-danger"
    end
  end
end
