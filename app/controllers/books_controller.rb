class BooksController < ApplicationController
  before_action :check_book_user, only: [:edit, :update, :destroy]
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully"
    else
      @user = current_user
      @books = Book.all
      redirect_to books_path
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    　
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully"
    else
      redirect_to edit_path(@book)
    end
  end

  def destry
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def check_book_user
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
  end

end
