$("#administration-detail").replaceWith("<%= escape_javascript(render(:partial => 'access_controls/form', locals:{role: @role, access_control: @access_control})) %>");
