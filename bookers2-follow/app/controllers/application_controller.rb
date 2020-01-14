class ApplicationController < ActionController::Base
	before_action :authenticate_user!,:configure_permitted_parameters, if: :devise_controller?
	# デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	# protect_from_forgery with: :exception

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  
  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  # def after_sign_out_path_for(resource)
  #   user_path(resource)
  # end

  def authenticate
    unless user_signed_in?
      redirect_to new_user_session_path#, :notice => 'if you want to add a notice'
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    if @user != @current_user
      redirect_to user_path(current_user)
    end
  end

  def correct_book
    @book = Book.find(params[:id])    
    @user = @book.user
    if @user != @current_user
      redirect_to books_path
    end
  end

end
