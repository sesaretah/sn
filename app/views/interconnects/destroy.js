$("#profile-section").replaceWith("<%= escape_javascript(render(:partial => 'profiles/connections', locals: {profile: @profile})) %>");
