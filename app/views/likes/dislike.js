$("#like-<%= @f.likeable_type%>-<%= @f.likeable_id%>").replaceWith("<%= escape_javascript(render(:partial => 'likes/like', locals: {type: @f.likeable_type, id: @f.likeable_id})) %>");
