class SessionsController < Devise::SessionsController
  def create
    super do |user|
      assign_start_role(user)
    end
  end

  def cas_login
    redirect_to "https://auth4.ut.ac.ir:8443/cas/login?service=https%3A%2F%2Fsn.ut.ac.ir%2Fusers%2Fservice"
  end
end
