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

  def assign_start_role(user)
    @start_point_roles = Role.where(start_point: true)
    for start_point_role in @start_point_roles
      @start_point_assignment = Assignment.where(user_id: user.id, role_id: start_point_role.id)
      if @start_point_assignment.blank?
        @start_point_assignment = Assignment.create(user_id: user.id, role_id: start_point_role.id)
      end
    end
  end

  def grant_access(ward, user)
    @flag = 0
    if user.assignments.blank?
      return false
    end
    if user.current_role_id.blank?
      return false
    else
      @ac = AccessControl.where(role_id: user.current_role_id).first
      if !@ac.blank?
        @flag = @ac["#{ward}"] && 1 || 0
      end
    end

    if @flag == 1 || is_admin(user)
      return true
    else
      return false
    end
  end

  def is_admin(user)
    @flag = false
    if !user.assignments.blank? && !user.current_role_id.blank?
      @ac_role = AccessControl.where(role_id: user.current_role_id).first
      if !@ac_role.blank? && @ac_role.ability_to_administrate
        @flag = true
      end
    end
    if @flag
      return true
    else
      return false
    end
  end

  def check_owner(obj)
    if obj.user_id == current_user.id || is_admin(current_user)
      return true
    else
      return false
    end
  end

end
