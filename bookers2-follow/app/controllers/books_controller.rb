class BooksController < ApplicationController
	before_action :authenticate
	before_action :correct_book, only: [:edit, :update]
	before_action :set_book, only: [:show, :edit, :update, :destroy,]
	def index
		@user = User.find(current_user.id)
		@book = Book.new
		@books = Book.all
		@favorite = Favorite.new
	end

	def show
		@user = User.find_by(id:params[:id])
		@favorite = Favorite.new
		@book_comment = BookComment.new 
    @book_comments = @book.book_comments
	end
	
  def create
		@book = Book.new(book_params)
		@book.user_id = current_user.id
  	if @book.save
  		redirect_to book_path(@book), notice: "successfully created book!"
		else
			@books = Book.all
			@user = User.find(current_user.id)
  		render 'index'
  	end
  end

	def edit
  end

  def update
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
		else
  		@books = Book.all
      @user = User.find(current_user.id)
      render action: :index
  	end
  end

  def destroy
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

	private
	def set_book
		@book = Book.find(params[:id])
	end

  def book_params
  	params.require(:book).permit(:title, :body)
  end
end