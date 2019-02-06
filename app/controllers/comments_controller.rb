class CommentsController < ApplicationController
  def discussion_comments
    @discussion = Discussion.find(params[:id])
  end
  def create
    @discussion = Discussion.find(params[:discussion_id])
    @comment = Comment.create(content: params[:content], discussion_id: params[:discussion_id], user_id: current_user.id)
  end

  def destroy
    @comment= Comment.find(params[:id])
    @discussion = @comment.discussion
    @comment.destroy
  end
end
