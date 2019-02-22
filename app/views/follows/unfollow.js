$("#follow-<%= @f.followable_type%>-<%= @f.followable_id%>").replaceWith("<%= escape_javascript(render(:partial => 'follows/follow', locals: {type: @f.followable_type, id: @f.followable_id})) %>");
