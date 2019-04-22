$('#shoa-share-modal-<%= @share.shareable_type%>-<%= @share.shareable_id%>').modal('hide');
$("#share-<%= @share.shareable_type%>-<%= @share.shareable_id%>").replaceWith("<%= escape_javascript(render(:partial => 'shares/share', locals: {type: @share.shareable_type, id: @share.shareable_id})) %>");
