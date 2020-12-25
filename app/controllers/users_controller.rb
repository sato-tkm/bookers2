class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.new
  end

  def create

  end

  def index
    @users = User.all
    @book = Book.new
    @user =current_user
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
       if  @user.update(user_params)
         flash[:notice] = "You have updated user successfully."
        redirect_to user_path(current_user.id)
       else
         flash[:notice] = " errors prohibited this obj from being saved:"
            render :edit
       end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


end
