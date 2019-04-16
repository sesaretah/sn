$("#notifications").after("<%= escape_javascript(render(:partial => 'notifications/list', locals: {notifications: @notifications, page: @page})) %>");
$("#more").replaceWith("<%= escape_javascript(render(:partial => 'notifications/more', locals: {page: @page})) %>");
