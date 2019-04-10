class RolesController < ApplicationController
  before_action :find_role,  only:[:access, :destroy, :change_start_point]

  def change_start_point
    if params[:to] == 'check'
      @role.start_point = true
    else
      @role.start_point = false
    end
    @role.save
  end

  def change_current_role
    @role = Role.find(params[:role_id])
    @assignment = Assignment.where(role_id: @role.id, user_id: current_user.id)
    if !@assignment.blank?
      current_user.current_role_id = params[:role_id]
      current_user.save
    end
  end

  def access
    if !@role.access_control.blank?
      @access_control = AccessControl.where(role_id: @role.id).first
    else
      @access_control = AccessControl.new
    end
  end

  def create
    @role = Role.create(title: params[:title])
  end

  def destroy
    @role.destroy
  end

  def find_role
    @role = Role.find(params[:id])
  end
end
