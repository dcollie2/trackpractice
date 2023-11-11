class SongsController < ApplicationController
  before_action :set_song, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /songs or /songs.json
  def index
    @songs = current_user.songs.all.order(title: :asc)
  end

  # GET /songs/1 or /songs/1.json
  def show; end

  # GET /songs/new
  def new
    @song = Song.new(user_id: current_user.id)
  end

  # GET /songs/1/edit
  def edit; end

  # POST /songs or /songs.json
  def create
    @song = Song.new(song_params)
    @song.user = current_user

    respond_to do |format|
      if @song.save
        format.html { redirect_to song_url(@song), notice: 'Song was successfully created.' }
      else
        format.html { redirect_to new_song_path, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /songs/1 or /songs/1.json
  def update
    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to song_url(@song), notice: 'Song was successfully updated.' }
      else
        format.html do
          redirect_to edit_song_path(@song), status: :unprocessable_entity, notice: 'Song was not successfully updated.'
        end
      end
    end
  end

  # DELETE /songs/1 or /songs/1.json
  def destroy
    @song.destroy

    respond_to do |format|
      flash[:notice] = 'Song was successfully destroyed.'
      format.html { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
      format.turbo_stream { redirect_to songs_url, notice: 'Song was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_song
    @song = current_user.songs.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def song_params
    params.require(:song).permit(:title, :lyrics, :chords, :shared, :user_id)
  end
end
