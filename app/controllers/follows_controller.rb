class FollowsController < ApplicationController
  def follow
    @follow = Follow.create(followable_id: params[:followable_id], followable_type: params[:followable_type], user_id: current_user.id)
  end

  def unfollow
    @follow = Follow.where(followable_id: params[:followable_id], followable_type: params[:followable_type], user_id: current_user.id).first
    @f = @follow
    if !@follow.blank?
      @follow.destroy
    end
  end
end
