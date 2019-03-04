$("#profile-section").replaceWith("<%= escape_javascript(render(:partial => 'profiles/bookmarks', locals: {profile: @profile})) %>");
