$("#profiles").after("<%= escape_javascript(render(:partial => 'profiles/list', locals: {profiles: @profiles, page: @page})) %>");
$("#more").replaceWith("<%= escape_javascript(render(:partial => 'profiles/more', locals: {page: @page})) %>");
