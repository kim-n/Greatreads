module SpecTestHelper   
  def login(user)
    session[:session_token] = user.session_token
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end
end