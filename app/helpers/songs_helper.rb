module SongsHelper
  def checkbox_icon(truth)
    '<i class="bi bi-check-circle-fill"></i>'.html_safe if truth
  end
end
