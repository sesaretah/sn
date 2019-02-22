$("#profile-section").replaceWith("<%= escape_javascript(render(:partial => 'profiles/shares', locals: {profile: @profile})) %>");
