class BooksController < ApplicationController

  before_action :authenticate_user!

  def show
    @savedbook = Book.find(params[:id])
    @book = Book.new
    # ここの引数いまいちわからん　なんとなくできてしまった
    @user = User.find(@savedbook.user_id)
  end

  def index
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    correct_book(@book)
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
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
      params.require(:book).permit(:title, :body)
    end

    def correct_book(book)
      if current_user.id != book.user.id
        redirect_to books_path
      end
    end
end
