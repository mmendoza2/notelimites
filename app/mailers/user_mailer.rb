class UserMailer < ActionMailer::Base
  default from: "mmendoza2@adsmex.com"

  def ntl_diario
    mail(to: "man.m25@gmail.com, alejo.benmar@gmail.com", subject: 'NTL Diario')
  end

  def login_email(user)
    @user = user
    mail(to: "man.m25@gmail.com", subject: 'login')
  end

  def login_email_api(user)
    @user = user
    mail(to: "man.m25@gmail.com", subject: 'login API')
  end

  def location_email(location, user)
    @user = user
    @location = location
    mail(to: "man.m25@gmail.com", subject: 'new location')
  end

  def location_email_api(location, user)
    @user = user
    @location = location
    mail(to: "man.m25@gmail.com", subject: 'new location API')
  end

  def ntl_user(user)
        @user = user
        mail(to: "man.m25@gmail.com" , subject: "#NoTeLimites #Hoy #NoMeAburro")
  end

end
