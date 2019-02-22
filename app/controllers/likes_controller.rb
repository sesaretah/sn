class LikesController < ApplicationController
  def like
    @like = Like.create(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], user_id: current_user.id)
  end

  def dislike
    @like = Like.where(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], user_id: current_user.id).first
    @f = @like
    if !@like.blank?
      @like.destroy
    end
  end
end
