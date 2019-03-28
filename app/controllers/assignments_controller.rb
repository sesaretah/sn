class AssignmentsController < ApplicationController
  def create
    @assignment = Assignment.create(user_id: params[:user_id], role_id: params[:role_id])
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
  end
end
