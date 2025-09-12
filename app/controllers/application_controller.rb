# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :set_time_zone, if: :current_user
  before_action :enable_hotflash
  before_action :set_variant

  private

  def set_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def set_variant
    request.variant = :turbo_native if turbo_native_app?
  end

  def turbo_native_app?
    # Detect Turbo Native (iOS/Android) shells via User-Agent, header, or opt-in param
    ua = request.user_agent.to_s
    ua.include?("Turbo Native") ||
      ua.include?("Hotwire Native") ||
      request.headers["X-Turbo-Native"].present? ||
      params[:native].present?
  end
end
