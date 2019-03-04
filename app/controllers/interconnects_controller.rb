class InterconnectsController < ApplicationController
  def req
    render layout: 'layouts/devise'
  end

  def connect
    @interconnect = current_user.interconnects.first
    if @interconnect.blank?
      @interconnect = Interconnect.create(user_id: current_user.id, provider: 'Divan', token: JWTWrapper.encode({ user_id: current_user.id }))
    end
    render layout: 'layouts/devise'
  end

  def destroy
    @interconnect = current_user.interconnects.find(params[:id])
    @profile = current_user.profile
    if !@interconnect.blank?
      @interconnect.destroy
    end
  end
end
