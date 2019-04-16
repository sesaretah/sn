class AccessControlsController < ApplicationController
  before_action :set_access_control, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:show, :create, :edit, :update, :destroy]
  # GET /access_controls
  # GET /access_controls.json
  def index
    @access_controls = AccessControl.all
  end

  # GET /access_controls/1
  # GET /access_controls/1.json
  def show
  end

  # GET /access_controls/new
  def new
    @access_control = AccessControl.new
  end

  # GET /access_controls/1/edit
  def edit
  end

  # POST /access_controls
  # POST /access_controls.json
  def create
    @access_control = AccessControl.new(access_control_params)

    respond_to do |format|
      if @access_control.save
        format.html { redirect_to @access_control, notice: 'Access control was successfully created.' }
        format.json { render :show, status: :created, location: @access_control }
        format.js
      else
        format.html { render :new }
        format.json { render json: @access_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_controls/1
  # PATCH/PUT /access_controls/1.json
  def update
    @access_control.ability_to_create_stream = false
    @access_control.ability_to_create_discussion = false
    @access_control.ability_to_comment = false
    @access_control.ability_to_create_question = false
    @access_control.ability_to_create_answer = false
    @access_control.ability_to_administrate = false
    respond_to do |format|
      if @access_control.update(access_control_params)
        format.html { redirect_to @access_control, notice: 'Access control was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_control }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @access_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_controls/1
  # DELETE /access_controls/1.json
  def destroy
    @access_control.destroy
    respond_to do |format|
      format.html { redirect_to access_controls_url, notice: 'Access control was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_admin
    if !grant_access('ability_to_administrate', current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_control
      @access_control = AccessControl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_control_params
      params.require(:access_control).permit(:uuid, :role_id, :ability_to_create_stream, :ability_to_create_discussion, :ability_to_comment, :ability_to_create_question, :ability_to_create_answer, :ability_to_administrate)
    end
end
