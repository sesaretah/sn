class AdministrationController < ApplicationController
  def index

  end

  def sections
      @section = params[:section]
  end
end
