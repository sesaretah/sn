class EducationsController < ApplicationController
  def create
    @profile = current_user.profile
    @education = Education.create(school_name: params[:school_name], grad_level: params[:grad_level], grad_year: params[:grad_year], field: params[:field], country: params[:country], city: params[:city], user_id: current_user.id)
  end

  def destroy
    @profile = current_user.profile
    @education = current_user.educations.find(params[:id])
    if !@education.blank?
      @education.destroy
    end
  end
end
