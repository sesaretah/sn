module Api::V2
  class ApiController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_filter :authenticate_user!, :except => [:likes, :like,:shares, :share,:follows, :follow, :authorized, :bookmarks, :bookmark, :check_asset]
    before_action :find_user, only: [:likes, :like, :shares, :share, :follows, :follow, :authorized, :bookmarks, :bookmark, :check_asset]
    before_action :find_asset, only: [:likes, :like, :shares, :share, :follows, :follow, :bookmarks, :bookmark]

    def authorized
      if @this_user
        render :json => {result: 'OK'}.to_json , :callback => params['callback']
      else
        render :json => {result: 'ERROR'}.to_json , :callback => params['callback']
      end
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
      render :json => {result: 'OK',bookmarks: @bookmarks.length, bookmarked: @bookmarked}.to_json , :callback => params['callback']
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
      render :json => {result: 'OK',follows: @follows.length, followed: @followed}.to_json , :callback => params['callback']
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
        @user_share = Share.where(shareable_id: @id, shareable_type: @type, user_id: @this_user.id).first
        if !@user_share.blank?
          @user_share.destroy
        else
          Share.create(shareable_id: @id, shareable_type: @type, user_id: @this_user.id)
          @shared = true
        end
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
      render :json => {result: 'OK',likes: @likes.length, liked: @liked}.to_json , :callback => params['callback']
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
      @item = params[:type].classify.constantize.find_by_external_id(params[:id])
      if !@item.blank?
        @type = @item.class.name
        @id = @item.id
      else
        head(500)
      end
    end



    def find_user
      @interconnect = Interconnect.find_by_uuid(params[:uuid])
      if !@interconnect.blank?
        @this_user = User.find(@interconnect.user_id)
      end

    end

  end
end
