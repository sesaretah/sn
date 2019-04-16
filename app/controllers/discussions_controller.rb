class DiscussionsController < ApplicationController
  def create
    if grant_access('ability_to_create_discussion', current_user)
      @discussion = Discussion.create(title: params[:title], post_id: params[:post_id], color: params[:color])
    end
  end
end
