module PracticesHelper

  def day_background(date, practices)
    if date > Date.today
      "bg-secondary"
    elsif practices.length > 0
      "bg-success"
    else
      "bg-danger"
    end
  end
end
