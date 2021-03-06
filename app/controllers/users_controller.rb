# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    byebug
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    redirect_to edit_user_path(@user), notice: "User was saved Successfully"
  end

  def user_params
    params.require(:user).permit(:name)
  end
end



