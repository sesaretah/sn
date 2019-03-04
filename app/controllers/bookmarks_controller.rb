class BookmarksController < ApplicationController
  def bookmark
    @bookmark = Bookmark.create(bookmarkable_id: params[:bookmarkable_id], bookmarkable_type: params[:bookmarkable_type], user_id: current_user.id)
  end

  def unbookmark
    @bookmark = Bookmark.where(bookmarkable_id: params[:bookmarkable_id], bookmarkable_type: params[:bookmarkable_type], user_id: current_user.id).first
    @f = @bookmark
    if !@bookmark.blank?
      @bookmark.destroy
    end
  end
end
