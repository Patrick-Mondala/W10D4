class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in? 
    !!current_user
  end

  def require_login
    redirect_to new_session_url unless logged_in?
  end

  def sign_in(user)
    session[:session_token] = user.reset_session_token
  end

  def sign_out
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def mod?(sub)
    if current_user.id == sub.moderator_id
      true
    else
      flash[:errors] = ["You are not a moderator for this sub"]
      redirect_to sub_url(sub)
    end
  end

  def op?(post)
    if current_user == post.author
      true
    else
      flash[:errors] = ["You are not the OP"]
      redirect_to post_url(post)
    end
  end
end