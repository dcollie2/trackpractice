module UsersHelper
  def practices_link(user)
    if current_user.admin? || user.make_practices_public?
      link_to user.email, user_practices_path(user)
    else
      user.email
    end
  end
end
