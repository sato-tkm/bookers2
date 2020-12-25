class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def index
    @user = current_user
    @book = Book.new
  	@books = Book.all
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

  def create
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have creatad book successfully."
    redirect_to book_path(@book)
    else
      @books = Book.all
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
        if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to  book_path(@book)
        else
        flash[:notice]= ' errors prohibited this obj from being saved:'
        render :edit
        end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

   def book_params
    params.require(:book).permit(:title, :body, :user_id)
   end
end
