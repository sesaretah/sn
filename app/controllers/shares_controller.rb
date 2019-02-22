class SharesController < ApplicationController
  def share
    @share = Share.create(shareable_id: params[:shareable_id], shareable_type: params[:shareable_type], user_id: current_user.id)
  end

  def unshare
    @share = Share.where(shareable_id: params[:shareable_id], shareable_type: params[:shareable_type], user_id: current_user.id).first
    @f = @share
    if !@share.blank?
      @share.destroy
    end
  end
end
