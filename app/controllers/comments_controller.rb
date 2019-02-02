class CommentsController < ApplicationController
  def create
    @comment = Comment.create(content: params[:content], discussion_id: params[:discussion_id], user_id: current_user.id)
  end
end
