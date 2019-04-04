class SessionsController < Devise::SessionsController
  def create
    super do |user|
      assign_start_role(user)
    end
  end
end
