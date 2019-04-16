class CommentsController < ApplicationController
  def discussion_comments
    @discussion = Discussion.find(params[:id])
  end
  def create
    if grant_access('ability_to_comment', current_user)
      @discussion = Discussion.find(params[:discussion_id])
      @comment = Comment.create(content: params[:content], discussion_id: params[:discussion_id], user_id: current_user.id)
    end
  end

  def destroy
    if check_owner(@comment)
      @comment= Comment.find(params[:id])
      @discussion = @comment.discussion
      @comment.destroy
    end
  end
end
