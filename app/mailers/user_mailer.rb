# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  default from: "noreply@yourapp.com"

  def org_invite(user, org)
    @user = user
    @org = org
    @invite_token = JsonWebToken.encode(user_id: user.id, exp: 7.days.from_now.to_i)
    @invite_url = edit_password_url(token: @invite_token)

    mail(to: @user.email, subject: "You've been invited to join #{@org.name}")
  end
end
