class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # def activation_email(user)
  #   @user = user
  #   @url  = 'http://example.com/login'
  #   mail(to: user.email, subject: 'Welcome to My Awesome Site')
  # end

  def request_confirm(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Request Recieved')
  end

  def activation_email(user)
     @user = user
     @url  = new_user_url({activation_token: @user.session_token})
     mail(to: @user.email, subject: 'Welcome to My Awesome Site')
   end

end
