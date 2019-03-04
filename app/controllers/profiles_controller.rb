class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :shares, :educations, :details, :connections, :bookmarks]
  before_action :check_owner, only: [:connections]
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  def connections

  end

  def shares

  end

  def educations

  end

  def bookmarks

  end

  def details

  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
  #  @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    @upload_ids = Upload.where(uploadable_type: 'Profile', uploadable_id: @profile.id).pluck(:id)
  end

  # POST /profiles
  # POST /profiles.json
  def create

  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
  #  @profile.destroy
  #  respond_to do |format|
  #    format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  end

  def check_owner
    if @profile.user_id != current_user.id
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :sex, :bio, :uuid, :user_id)
    end
end
