class PracticesController < ApplicationController
  before_action :set_practice, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /practices or /practices.json
  def index
    @practices = current_user.practices.order(practice_date: :desc)
  end

  # GET /practices/1 or /practices/1.json
  def show
  end

  # GET /practices/new
  def new
    @practice = Practice.new(user: current_user, practice_date: DateTime.current)
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices or /practices.json
  def create
    @practice = current_user.practices.new(practice_params)

    respond_to do |format|
      if @practice.save
        format.html { redirect_to practices_url, notice: 'Practice was successfully created.' }
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /practices/1 or /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to practices_url, notice: 'Practice was successfully updated.' }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1 or /practices/1.json
  def destroy
    @practice.destroy

    respond_to do |format|
      format.html { redirect_to practices_url, notice: 'Practice was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@practice) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_practice
    @practice = current_user.practices.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def practice_params
    params.require(:practice).permit(:practice_date, :minutes, :notes, :user_id, :focus_id, :song_id)
  end
end
