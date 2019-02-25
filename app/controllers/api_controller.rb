class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:make_post, :login, :sign_up]
  #before_action :is_admin, only: []

  def make_post
    @stream = Stream.find(params[:stream_id])
    @post = Post.new(user_id: current_user.id, title: params[:title], raw_content: params[:content], content: params[:content], stream_id: @stream.id)
    if @post.save
      render :json => {result: 'OK', id: @post.id}.to_json , :callback => params['callback']
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
end
