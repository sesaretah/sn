$("#profile-section").replaceWith("<%= escape_javascript(render(:partial => 'profiles/educations', locals: {profile: @profile})) %>");
