class PracticesController < ApplicationController
  before_action :set_focus_user, only: :index
  before_action :set_practice, only: %i[ show edit update destroy ]
  before_action :set_current_week, only: :index
  # before_action :set_focus_user, only: :index
  before_action :authenticate_user!

  # GET /practices or /practices.json
  def index
    @practices = @focus_user.practices.in_week(@current_week).order(practice_date: :desc)
  end

  # GET /practices/1 or /practices/1.json
  def show
  end

  # GET /practices/new
  def new
    @practice = Practice.new(user: current_user, practice_date: DateTime.current.in_time_zone(current_user.time_zone))
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices or /practices.json
  def create
    @practice = current_user.practices.new(practice_params)

    respond_to do |format|
      if @practice.save
        format.html { redirect_to practices_url, success: 'Practice was successfully created.' }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /practices/1 or /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        flash[:notice] = "Practice was successfully updated."
        format.html { redirect_to practices_url, notice: 'Practice was successfully updated.' }
        format.turbo_stream { render turbo_stream: [
          turbo_stream.replace(@practice, partial: "practices/practice", locals: { practice: @practice })
          ]
         }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1 or /practices/1.json
  def destroy
    @practice.destroy

    respond_to do |format|
      flash[:notice] = "Practice was successfully destroyed."
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@practice), notice: 'Practice was successfully destroyed.' }
    end
  end

  private

  def set_focus_user
    if params[:user_id]
      if current_user.admin?
        @focus_user = User.find(params[:user_id])
      else
        @focus_user = User.with_public_practices#.where(id: params[:user_id])
        if @focus_user.blank?
          flash[:alert] = "User not found."
          redirect_to practices_url(@current_user)
        else
          @focus_user = @focus_user.first
        end
      end
    end
    @focus_user ||= current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_practice
    @practice = current_user.practices.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def practice_params
    params.require(:practice).permit(:practice_date, :minutes, :notes, :user_id, :focus_id, :song_id)
  end

  def set_current_week
    # if params[:week] is a valid date, set @current_week to that date
    # if params[:week] is not present or invalid, use the current week
    # if params[:week] is in the future, use the current week
    @current_week = Date.current.beginning_of_week
    if params[:week]
      begin
        @current_week = Date.parse(params[:week]).beginning_of_week
      rescue ArgumentError
      end
    end
  end
end
