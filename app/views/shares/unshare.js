$("#share-<%= @f.shareable_type%>-<%= @f.shareable_id%>").replaceWith("<%= escape_javascript(render(:partial => 'shares/share', locals: {type: @f.shareable_type, id: @f.shareable_id})) %>");
