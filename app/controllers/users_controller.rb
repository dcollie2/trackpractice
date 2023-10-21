# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user_edit, only: %i[edit update]
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = if current_user.admin?
               User.all
             else
               User.with_public_practices + [current_user]
             end
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.turbo_stream { redirect_to users_url, notice: 'User was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      flash[:notice] = 'User was successfully destroyed.'
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.turbo_stream { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def set_user
    @user = if current_user.admin?
              User.find(params[:id])
            elsif params[:id] == current_user.id.to_s
              current_user
            else
              User.with_public_practices.find(params[:id])
            end
  end

  def authorize_user_edit
    return if current_user.admin? || current_user == User.find(params[:id])

    flash[:error] = 'You cannot view that user.'
    redirect_to root_path
  end

  def user_params
    if current_user.admin?
      params.require(:user).permit(:email, :admin, :make_practices_public, :time_zone)
    else
      params.require(:user).permit(:email, :make_practices_public, :time_zone)
    end
  end
end
