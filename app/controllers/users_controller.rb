class UsersController < ApplicationController
  before_action :check_user, only: [:edit, :update]

  def index
    @user = current_user
    @new_book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = Book.where(user_id:@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully"
    else
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def check_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end
end
