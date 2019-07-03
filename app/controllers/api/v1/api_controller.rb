module Api::V1
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_filter :authenticate_user!, :except => [:make_post, :login, :sign_up, :likes, :like,:shares, :share,:follows, :follow, :bookmarks, :bookmark, :make_stream,:edit_post, :delete_post, :edit_stream,:delete_stream]
    before_action :find_asset, only: [:likes, :like, :shares, :share, :follows, :follow, :bookmarks, :bookmark, :edit_post,:delete_post]
    before_action :stream_owner, only: [:edit_stream, :delete_stream]

    def make_post
      @stream = Stream.find(params[:stream_id])
      @post = Post.new(user_id: current_user.id, title: params[:title], raw_content: params[:content], content: params[:content], stream_id: @stream.id, link: params[:link], external_id: params[:external_id], provider: params[:provider], external_parent_id: params[:external_parent_id],  external_parent_type: params[:external_parent_type])
      if @post.save
        render :json => {result: 'OK', id: @post.id}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def edit_post
      if @item.user_id != current_user.id
        head(403)
      end

      if !params[:title].blank?
        @item.title = params[:title]
      end
      if !params[:content].blank?
        @item.content = params[:content]
        @item.raw_content = params[:content]
      end

      if @item.save
        render :json => {result: 'OK', id: @item.id}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def delete_post
      if @item.user_id != current_user.id
        head(403)
      end
      if @item.destroy
        render :json => {result: 'OK'}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end


    def make_stream
      @stream = Stream.new(title: params[:title], details: params[:content], user_id: current_user.id)
      if @stream.save
        render :json => {result: 'OK', id: @stream.id}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def stream_owner
      @stream = Stream.find_by_uuid(params[:id])
      if @stream.blank? || @stream.user_id != current_user.id
        head(403)
      end
    end

    def edit_stream
      if !@stream.blank?
        if !params[:title].blank?
          @stream.title = params[:title]
        end
        if !params[:content].blank?
          @stream.content = params[:content]
          @stream.raw_content = params[:content]
        end
      end
      if !@stream.blank? && @stream.save
        render :json => {result: 'OK', id: @stream.id}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def delete_stream
      if @stream.destroy
        render :json => {result: 'OK'}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
    end

    def streams
      if params[:page].blank?
        @page = 1
      else
        @page = params[:page]
      end
      @streams = Stream.all.paginate(:page => @page, :per_page => 10)
      @result = []
      for stream in @streams
        @result << {id: stream.id , title: stream.title }
      end
      render :json => {result: 'OK', streams: @result, count: Stream.all.count, page: @page }.to_json , :callback => params['callback']
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
    def likes
      @liked = false
      if user_signed_in?
        @user_like = Like.where(likeable_id: @id, likeable_type: @type, user_id: current_user.id).first
        if !@user_like.blank?
          @liked = true
        end
      end

      @likes = Like.where(likeable_id: @id, likeable_type: @type)
      render :json => {result: 'OK', likes: @likes.length, liked: @liked}.to_json , :callback => params['callback']
    end

    def like
      @liked = false
      if  user_signed_in?
        @user_like = Like.where(likeable_id: @id, likeable_type: @type, user_id: current_user.id).first
        if !@user_like.blank?
          @user_like.destroy
        else
          Like.create(likeable_id: @id, likeable_type: @type, user_id: current_user.id)
          @liked = true
        end
      end
      @likes = Like.where(likeable_id: @id, likeable_type: @type)
      render :json => {result: 'OK',likes: @likes.length, liked: @liked}.to_json , :callback => params['callback']
    end

    def bookmarks
      @bookmarked = false
      if user_signed_in?
        @user_bookmark = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type, user_id: current_user.id).first
        if !@user_bookmark.blank?
          @bookmarked = true
        end
      end

      @bookmarks = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type)
      render :json => {result: 'OK', bookmarks: @bookmarks.length, bookmarked: @bookmarked}.to_json , :callback => params['callback']
    end

    def bookmark
      @bookmarked = false
      if user_signed_in?
        @user_bookmark = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type, user_id: current_user.id).first
        if !@user_bookmark.blank?
          @user_bookmark.destroy
        else
          Bookmark.create(bookmarkable_id: @id, bookmarkable_type: @type, user_id: current_user.id)
          @bookmarked = true
        end
      end
      @bookmarks = Bookmark.where(bookmarkable_id: @id, bookmarkable_type: @type)
      render :json => {result: 'OK',bookmarks: @bookmarks.length, bookmarked: @bookmarked}.to_json , :callback => params['callback']
    end

    def follows
      @followed = false
      if user_signed_in?
        @user_follow = Follow.where(followable_id: @id, followable_type: @type, user_id: current_user.id).first
        if !@user_follow.blank?
          @followed = true
        end
      end

      @follows = Follow.where(followable_id: @id, followable_type: @type)
      render :json => {result: 'OK', follows: @follows.length, followed: @followed}.to_json , :callback => params['callback']
    end

    def follow
      @followed = false
      if user_signed_in?
        @user_follow = Follow.where(followable_id: @id, followable_type: @type, user_id: current_user.id).first
        if !@user_follow.blank?
          @user_follow.destroy
        else
          Follow.create(followable_id: @id, followable_type: @type, user_id: current_user.id)
          @followed = true
        end
      end
      @follows = Follow.where(followable_id: @id, followable_type: @type)
      render :json => {result: 'OK',follows: @follows.length, followed: @followed}.to_json , :callback => params['callback']
    end

    def shares
      @shared = false
      if user_signed_in?
        @user_share = Share.where(shareable_id: @id, shareable_type: @type, user_id: current_user.id).first
        if !@user_share.blank?
          @shared = true
        end
      end

      @shares = Share.where(shareable_id: @id, shareable_type: @type)
      render :json => {result: 'OK', shares: @shares.length, shared: @shared}.to_json , :callback => params['callback']
    end

    def share
      @shared = false
      if user_signed_in?
        Share.create(shareable_id: @id, shareable_type: @type, user_id: current_user.id, stream_id: params[:stream_id])
        @shared = true
      end
      @shares = Share.where(shareable_id: @id, shareable_type: @type)
      render :json => {result: 'OK',shares: @shares.length, shared: @shared}.to_json , :callback => params['callback']
    end

    def find_asset
      case
      when params[:id]
        @item = Post.find(params[:id])
        if !@item.blank?
          @type = 'Post'
          @id = @item.id
        else
          head(404)
        end
      when params[:stream_id]
        @item = Stream.find(params[:stream_id])
        if !@item.blank?
          @type = 'Stream'
          @id = @item.id
        else
          head(404)
        end
      end
    end
  end
end
