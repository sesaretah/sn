class HomeController < ApplicationController
  def index
    @profile_follows = current_user.follows.where(followable_type: 'Profile')
    @profile_ids = []
    for profile_follow in @profile_follows
      @profile_ids << Profile.find_by_uuid(profile_follow.followable_id)
    end
    @stream_follows = current_user.follows.where(followable_type: 'Stream').pluck(:followable_id)
    @shares = Share.where('user_id IN (?) OR stream_id IN (?)', @profile_ids, @stream_follows).order('created_at desc')
  end
end
