class BookCommentsController < ApplicationController
   def create
    @book = Book.find(params[:book_id])
    @book_comment = @book.book_comments.build(book_comment_params)
    @book_comment.user_id = current_user.id
    if @book_comment.save
      render :index
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    if @book_comment.destroy
      render :index
    end
  end

  private
    def book_comment_params
      params.require(:book_comment).permit(:content, :book_id, :user_id)
    end
end
