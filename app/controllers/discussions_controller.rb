class DiscussionsController < ApplicationController
  def create
    @discussion = Discussion.create(title: params[:title], post_id: params[:post_id], color: params[:color])
  end
end
