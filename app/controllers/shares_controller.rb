class SharesController < ApplicationController
  def share
    @share = Share.create(shareable_id: params[:shareable_id], shareable_type: params[:shareable_type], user_id: current_user.id, stream_id: params[:stream_id])
  end

  def unshare
    if params[:stream_id].blank?
      @share = Share.where(shareable_id: params[:shareable_id], shareable_type: params[:shareable_type], user_id: current_user.id).first
    else
      @share = Share.where(shareable_id: params[:shareable_id], shareable_type: params[:shareable_type], user_id: current_user.id, stream_id: params[:stream_id]).first
    end
    @f = @share
    if !@share.blank?
      @share.destroy
    end
  end
end
