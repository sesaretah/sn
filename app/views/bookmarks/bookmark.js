$("#bookmark-<%= @bookmark.bookmarkable_type%>-<%= @bookmark.bookmarkable_id%>").replaceWith("<%= escape_javascript(render(:partial => 'bookmarks/bookmark', locals: {type: @bookmark.bookmarkable_type, id: @bookmark.bookmarkable_id})) %>");