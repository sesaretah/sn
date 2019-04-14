class LikesController < ApplicationController
  def like
    @like = Like.where(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], user_id: current_user.id).first
    if @like.blank?
      @like = Like.create(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], user_id: current_user.id)
    end
  end

  def dislike
    @like = Like.where(likeable_id: params[:likeable_id], likeable_type: params[:likeable_type], user_id: current_user.id).first
    @f = @like
    if !@like.blank?
      @like.destroy
    end
  end
end
