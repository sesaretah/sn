$("#discussion-comments").replaceWith("<%= escape_javascript(render(:partial => 'comments/discussion_comments', locals:{discussion: @discussion})) %>");
