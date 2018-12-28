class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


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
