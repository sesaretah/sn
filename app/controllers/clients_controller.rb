class ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def update
    @client = Client.where(uuid: params[:uuid]).first
    if @client.blank?
      @client = Client.create(user_id:current_user.id, uuid: params[:uuid], client_type: params[:type])
    end
  end
end
