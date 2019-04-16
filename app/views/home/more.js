$("#shares").after("<%= escape_javascript(render(:partial => 'home/shares', locals: {shares: @shares, page: @page})) %>");
$("#more").replaceWith("<%= escape_javascript(render(:partial => 'home/more', locals: {page: @page})) %>");
