$("#like-<%= @like.likeable_type%>-<%= @like.likeable_id%>").replaceWith("<%= escape_javascript(render(:partial => 'likes/like', locals: {type: @like.likeable_type, id: @like.likeable_id})) %>");
