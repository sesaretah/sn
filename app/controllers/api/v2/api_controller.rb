module Api::V2
  class ApiController < ApplicationController
    include ActionView::Helpers::TextHelper
    skip_before_action :verify_authenticity_token
    before_filter :authenticate_user!, :except => [:likes, :like,:shares, :share,:follows, :follow, :authorized, :bookmarks, :bookmark, :check_asset, :streams, :wall, :login, :sign_up, :view_share, :view_stream, :view_discussion, :user_streams, :view_profile, :view_educations, :view_profile_bookmarks]
    before_action :find_user, only: [:likes, :like, :shares, :share, :follows, :follow, :authorized, :bookmarks, :bookmark, :check_asset, :streams, :wall, :view_share, :view_stream, :view_discussion, :user_streams, :view_profile, :view_educations, :view_profile_bookmarks]
    before_action :find_asset, only: [:likes, :like, :shares, :share, :follows, :follow, :bookmarks, :bookmark]

    def authorized
      if @this_user
        render :json => {result: 'OK'}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def wall
      if params[:page].blank?
        @page = 1
      else
        @page = params[:page].to_i
      end
      @profile_follows = current_user.follows.where(followable_type: 'Profile')
      @profile_ids = []
      for profile_follow in @profile_follows
        @profile_ids << Profile.find_by_uuid(profile_follow.followable_id)
      end
      @stream_follows = current_user.follows.where(followable_type: 'Stream').pluck(:followable_id)
      @shares = Share.where('user_id IN (?) OR stream_id IN (?)', @profile_ids, @stream_follows)
      @shares = @shares.paginate(:page => @page, per_page: 10).order('created_at desc')
      @result= []
      for share in @shares
        @result << {id: share.id, shareable_id: share.shareable_id ,type: share.shareable_type, title: share.shareable.title, content: truncate(share.shareable.raw_content, length: 80) ,'cover' => request.base_url + share.shareable.cover('medium'), updated_at: share.shareable.updated_at, liked: Like.liked(@this_user, share.shareable.id), likes: Like.likes(share.shareable.id), bookmarked: Bookmark.bookmarked(@this_user, share.shareable.id), bookmarks: Bookmark.bookmarks(share.shareable.id), followed: Follow.followed(@this_user, share.shareable.id), follows: Follow.follows(share.shareable.id), shared: Share.shared(@this_user, share.shareable.id), shares: Share.shares(share.shareable.id)}
      end
      render :json => {result: 'OK', shares: @result, page: @page}.to_json , :callback => params['callback']
    end

    def view_discussion
      @discussion = Discussion.find(params[:id])
      @comments = []
      for comment in @discussion.comments
        @comments << {id: comment.id, title: comment.user.profile.name ,content: comment.content, 'cover' => request.base_url + comment.user.profile.image('medium') , updated_at: comment.updated_at}
      end
      render :json => {result: 'OK', discussion: @discussion, comments: @comments}.to_json , :callback => params['callback']
    end

    def view_share
      @share =Share.find(params[:id])
      @result = {id: @share.shareable.id, type: @share.shareable_type, title: @share.shareable.title, content: @share.shareable.content.gsub('/system/', request.base_url + '/system/') ,'cover' => request.base_url + @share.shareable.cover('medium'), updated_at: @share.shareable.updated_at, liked: Like.liked(@this_user, @share.shareable.id), likes: Like.likes(@share.shareable.id), bookmarked: Bookmark.bookmarked(@this_user, @share.shareable.id), bookmarks: Bookmark.bookmarks(@share.shareable.id), followed: Follow.followed(@this_user, @share.shareable.id), follows: Follow.follows(@share.shareable.id), shared: Share.shared(@this_user, @share.shareable.id), shares: Share.shares(@share.shareable.id)}
      @discussions= []
      if @share.shareable_type == 'Post'
        for discussion in Discussion.where(post_id: @share.shareable.id)
          @discussions << {id: discussion.id, title: discussion.title, color: discussion.color, updated_at: discussion.updated_at}
        end
      end
      render :json => {result: 'OK', share: @result, discussions: @discussions}.to_json , :callback => params['callback']
    end


    def view_profile
      @profile = Profile.find(params[:id])
      @result = {id: @profile.id, type: 'Profile', title: @profile.title, content: @profile.content.gsub('/system/', request.base_url + '/system/') ,'cover' => request.base_url + @profile.cover('medium'), updated_at: @profile.updated_at, liked: Like.liked(@this_user, @profile.id), likes: Like.likes(@profile.id), bookmarked: Bookmark.bookmarked(@this_user, @profile.id), bookmarks: Bookmark.bookmarks(@profile.id), followed: Follow.followed(@this_user, @profile.id), follows: Follow.follows(@profile.id), shared: Share.shared(@this_user, @profile.id), shares: Share.shares(@profile.id)}
      render :json => {result: 'OK', profile: @result}.to_json , :callback => params['callback']
    end

    def view_educations
      @profile = Profile.find(params[:id])
      @result = []
      for education in @profile.user.educations
        @result << {profile_id:   @profile.id, id: education.id, school_name: education.school_name, grad_level: education.grad_level, grad_year: education.grad_year, field: education.field, country: education.country, city: education.city}
      end
      render :json => {result: 'OK', educations: @result}.to_json , :callback => params['callback']
    end

    def view_profile_bookmarks
      @profile = Profile.find(params[:id])
      @result = []
      for bookmark in profile.user.bookmarks.order('created_at desc')
        @result << {profile_id:   @profile.id, title: bookmark.bookmarkable.title, content: bookmark.bookmarkable.content.gsub('/system/', request.base_url + '/system/') ,'cover' => request.base_url + bookmark.bookmarkable.cover('medium'), updated_at: bookmark.bookmarkable.updated_at, liked: Like.liked(@this_user, bookmark.bookmarkable.id), likes: Like.likes(bookmark.bookmarkable.id), bookmarked: Bookmark.bookmarked(@this_user, bookmark.bookmarkable.id), bookmarks: Bookmark.bookmarks(bookmark.bookmarkable.id), followed: Follow.followed(@this_user, bookmark.bookmarkable.id), follows: Follow.follows(bookmark.bookmarkable.id), shared: Share.shared(@this_user, bookmark.bookmarkable.id), shares: Share.shares(bookmark.bookmarkable.id)}
      end
      render :json => {result: 'OK', educations: @result}.to_json , :callback => params['callback']
    end


    def bookmarks
      @bookmarked = false
      if @this_user
        @user_bookmark = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type, user_id: @this_user.id).first
        if !@user_bookmark.blank?
          @bookmarked = true
        end
      end

      @bookmarks = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type)
      render :json => {result: 'OK', bookmarks: @bookmarks.length, bookmarked: @bookmarked}.to_json , :callback => params['callback']
    end

    def bookmark
      @bookmarked = false
      if @this_user
        @user_bookmark = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type, user_id: @this_user.id).first
        if !@user_bookmark.blank?
          @user_bookmark.destroy
        else
          Bookmark.create(bookmarkable_id: @id, bookmarkable_type: @type, user_id: @this_user.id)
          @bookmarked = true
        end
      end
      @bookmarks = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type)
      render :json => {result: 'OK',bookmarks: @bookmarks.length, bookmarked: @bookmarked, uuid: @id}.to_json , :callback => params['callback']
    end

    def follows
      @followed = false
      if @this_user
        @user_follow = Follow.where(followable_id: @id, followable_type: @type, user_id: @this_user.id).first
        if !@user_follow.blank?
          @followed = true
        end
      end

      @follows = Follow.where(followable_id: @id, followable_type: @type)
      render :json => {result: 'OK', follows: @follows.length, followed: @followed}.to_json , :callback => params['callback']
    end

    def follow
      @followed = false
      if @this_user
        @user_follow = Follow.where(followable_id: @id, followable_type: @type, user_id: @this_user.id).first
        if !@user_follow.blank?
          @user_follow.destroy
        else
          Follow.create(followable_id: @id, followable_type: @type, user_id: @this_user.id)
          @followed = true
        end
      end
      @follows = Follow.where(followable_id: @id, followable_type: @type)
      render :json => {result: 'OK',follows: @follows.length, followed: @followed, uuid: @id}.to_json , :callback => params['callback']
    end

    def shares
      @shared = false
      if @this_user
        @user_share = Share.where(shareable_id: @id, shareable_type: @type, user_id: @this_user.id).first
        if !@user_share.blank?
          @shared = true
        end
      end

      @shares = Share.where(shareable_id: @id, shareable_type: @type)
      render :json => {result: 'OK', shares: @shares.length, shared: @shared}.to_json , :callback => params['callback']
    end

    def share
      @shared = false
      if @this_user
        Share.create(shareable_id: @id, shareable_type: @type, user_id: @this_user.id, stream_id: params[:stream])
        @shared = true
      end
      @shares = Share.where(shareable_id: @id, shareable_type: @type)
      render :json => {result: 'OK',shares: @shares.length, shared: @shared}.to_json , :callback => params['callback']
    end


    def likes
      @liked = false
      if @this_user
        @user_like = Like.where(likeable_id: @id, likeable_type: @type, user_id: @this_user.id).first
        if !@user_like.blank?
          @liked = true
        end
      end

      @likes = Like.where(likeable_id: @id, likeable_type: @type)
      render :json => {result: 'OK', likes: @likes.length, liked: @liked}.to_json , :callback => params['callback']
    end

    def like
      @liked = false
      if @this_user
        @user_like = Like.where(likeable_id: @id, likeable_type: @type, user_id: @this_user.id).first
        if !@user_like.blank?
          @user_like.destroy
        else
          Like.create(likeable_id: @id, likeable_type: @type, user_id: @this_user.id)
          @liked = true
        end
      end
      @likes = Like.where(likeable_id: @id, likeable_type: @type)
      render :json => {result: 'OK', likes: @likes.length, liked: @liked, uuid: @id}.to_json , :callback => params['callback']
    end

    def check_asset
      if @this_user
        @item = params[:type].classify.constantize.find_by_external_id(params[:id])
        if @item.blank?
          @item = params[:type].classify.constantize.create(title: params[:title], content: params[:content], link: params[:link], external_id: params[:id])
        end
      end
      if !@item.blank?
        render :json => {result: 'OK'}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def find_asset
      @item = params[:type].classify.constantize.find_by_external_id(params[:id]) rescue nil
      if !@item.blank?
        @type = @item.class.name
        @id = @item.id
      else
        @item = params[:type].classify.constantize.find(params[:id]) rescue nil
        if !@item.blank?
          @type = @item.class.name
          @id = @item.id
        else
          head(500)
        end
      end
    end

    def streams
      @streams = []
      if @this_user
        @streams = @this_user.streams
      end
      @result = []
      for stream in @streams
        @result << {id: stream.id, title: stream.title, content: truncate(stream.raw_content, length: 80) ,'cover' => request.base_url + stream.cover('medium'), updated_at: stream.updated_at, liked: Like.liked(@this_user, stream.id), likes: Like.likes(stream.id), bookmarked: Bookmark.bookmarked(@this_user, stream.id), bookmarks: Bookmark.bookmarks(stream.id), followed: Follow.followed(@this_user, stream.id), follows: Follow.follows(stream.id), shared: Share.shared(@this_user, stream.id), shares: Share.shares(stream.id)}
      end
      render :json => {result: 'OK', streams: @result}.to_json , :callback => params['callback']
    end

    def view_stream
      @stream = Stream.find(params[:id])
      @result = {id: @stream.id, title: @stream.title, content: truncate(@stream.raw_content, length: 50) ,'cover' => request.base_url + @stream.cover('medium'), updated_at: @stream.updated_at, liked: Like.liked(@this_user, @stream.id), likes: Like.likes(@stream.id), bookmarked: Bookmark.bookmarked(@this_user, @stream.id), bookmarks: Bookmark.bookmarks(@stream.id), followed: Follow.followed(@this_user, @stream.id), follows: Follow.follows(@stream.id), shared: Share.shared(@this_user, @stream.id), shares: Share.shares(@stream.id)}
      @shares = []
      for share in Share.where(stream_id: @stream.id)
        @shares << {id: share.id, title: share.shareable.title, content: truncate(share.shareable.raw_content, length: 80) ,'cover' => request.base_url + share.shareable.cover('medium'), updated_at: share.shareable.updated_at , liked: Like.liked(@this_user, share.shareable.id), likes: Like.likes(share.shareable.id), bookmarked: Bookmark.bookmarked(@this_user, share.shareable.id), bookmarks: Bookmark.bookmarks(share.shareable.id), followed: Follow.followed(@this_user, share.shareable.id), follows: Follow.follows(share.shareable.id), shared: Share.shared(@this_user, share.shareable.id), shares: Share.shares(share.shareable.id)}
      end
      render :json => {result: 'OK', stream: @result, shares: @shares}.to_json , :callback => params['callback']
    end


    def login
      if User.find_by_username(params['username']).try(:valid_password?, params[:password])
        @user = User.find_by_username(params['username'])
        render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id }), user_id: @user.id}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR',  error: I18n.t(:doesnt_match) }.to_json , :callback => params['callback']
      end
    end


    def sign_up
      @user = User.new(username: params['username'], mobile: params['username'], password: params['password'], password_confirmation: params['password_confirmation'])
      if @user.save
        @profile = Profile.create(user_id: @user.id, name: params[:name])
        render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id })}.to_json, :callback => params['callback']
      else
        render :json => {result: 'ERROR', error: @user.errors }.to_json , :callback => params['callback']
      end
    end



    def find_user
      @interconnect = Interconnect.find_by_uuid(params[:uuid])
      if !@interconnect.blank?
        @this_user = User.find(@interconnect.user_id)
      else
        @this_user = current_user
      end

    end

  end
end
