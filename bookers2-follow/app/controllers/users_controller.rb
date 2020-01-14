class UsersController < ApplicationController
	before_action :authenticate
	before_action :correct_user, only: [:edit, :update,]
	before_action :set_user, only: [:show, :edit, :update,]

	def index
		@book = Book.new
		@users = User.all
		@user = User.find(current_user.id)
	end

	def show
		@book = Book.new
	end
	
	def following
      @user  = User.find(params[:id])
      @users = @user.followings
      render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
		else
  		render action: :edit
  	end
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

# url直接防止　メソッドを自己定義してbefore_actionで発動。
# before_action :baria_user, only: [:update]
# def baria_user
#  unless params[:id].to_i == current_user.id
# 	 redirect_to user_path(current_user)
#  end
# end
