class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    unless @book.iine?(current_user)
      @book.iine(current_user)
      @book.reload
      redirect_back(fallback_location: root_url)#応急処置
      respond_to do |format|
        # format.html { redirect_to request.referrer || root_url }
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end

  def destroy
    @book = Favorite.find(params[:id]).book
    if @book.iine?(current_user)
      @book.uniine(current_user)
      @book.reload
      redirect_back(fallback_location: root_url)#応急処置
      respond_to do |format|
        # format.html { redirect_to request.referrer || root_url }
        format.html { redirect_back(fallback_location: root_url) }
        format.js
      end
    end
  end
end