class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  def show
  end

  def remoted
    @upload = Upload.find(params[:id])
    @upload.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.attachment = params[:file]
    if params[:upload][:uploadable_id] != "0"
      @item = params[:upload][:uploadable_type].classify.constantize.find(params[:upload][:uploadable_id])
      @upload.uploadable_id = @item[:id]
    end
    respond_to do |format|
      if @upload.save
        format.json { render :show, status: :created, location: @upload }
        format.js
      else
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.json { render :show, status: :ok, location: @upload }
        format.js
      else
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end
  private

  def set_upload
    @upload = Upload.find(params[:id])
  end

  def upload_params
    params.require(:upload).permit(:uploadable_type, :uploadable_id, :attachment_type, :crop_x, :crop_y, :crop_w, :crop_h)
  end
end
