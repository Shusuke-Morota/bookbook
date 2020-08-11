class BooksController < ApplicationController
  def index
  	@books = Book.all
  end

  def show
  	@book = Book.find(params[:id])
  end

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
  		redirect_to book_path(@book), notice: "投稿に成功しました！"
  	else
  		render :new
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  	unless @book.user_id == current_user.id
  		redirect_to books_path, alert: "不正なアクセスです！"
  	end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book), notice: "投稿に成功しました！"
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
end
