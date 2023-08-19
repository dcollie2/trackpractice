class FociController < ApplicationController
  before_action :set_focus, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /foci or /foci.json
  def index
    @foci = current_user.foci.all
  end

  # GET /foci/1 or /foci/1.json
  def show
  end

  # GET /foci/new
  def new
    @focus = Focus.new(user_id: current_user.id)
  end

  # GET /foci/1/edit
  def edit
  end

  # POST /foci or /foci.json
  def create
    @focus = Focus.new(focus_params)
    @focus.user = current_user
    respond_to do |format|
      if @focus.save
        format.html { redirect_to foci_url, notice: "Focus was successfully created." }
        format.json { render :show, status: :created, location: @focus }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @focus.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foci/1 or /foci/1.json
  def update
    respond_to do |format|
      if @focus.update(focus_params)
        format.html { redirect_to foci_url, notice: "Focus was successfully updated." }
        format.json { render :show, status: :ok, location: @focus }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @focus.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foci/1 or /foci/1.json
  def destroy
    @focus.destroy

    respond_to do |format|
      format.html { redirect_to foci_url, notice: "Focus was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_focus
      @focus = current_user.foci.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def focus_params
      params.require(:focus).permit(:short_description, :user_id)
    end
end
