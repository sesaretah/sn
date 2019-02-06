class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  require 'jalali_date'
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for,:after_inactive_sign_up_path_for,     :after_sign_up_path_for]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
  end


  def manage_uploads(item)
    if !params[:attachments].blank?
      @upload_ids = params[:attachments].split(',')
      for upload_id in @upload_ids
        if !upload_id.blank?
          @upload = Upload.find_by_id(upload_id)
          if !@upload.blank?
            @upload.uploadable_id = item.id
            @upload.save
          end
        end
      end
    end
  end

end
