class MissionsController < ApplicationController
  authorize_actions_for Mission
  before_action :set_mission, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except=>[:index, :show]

  def index
    @title = "Missions"
    @missions = Mission.all
  end

  def show
    if params[:modal]
      render :modal_show, :layout=>false
    else
      @title = "Mission : #{@mission.title}"
      render :show
    end
  end

  def new
    @title = "Créer une mission"
    @mission = Mission.new
  end

  def edit
    @title = "Modifier la mission : #{@mission.title}"
  end

  def create
    @mission = Mission.new(mission_params)

    if @mission.save
      redirect_to @mission, notice: 'Mission was successfully created.'
    else
      @title = "Créer une mission"
      render :new
    end
  end

  def update
    if @mission.update(mission_params)
      redirect_to @mission, notice: 'Mission was successfully updated.'
    else
      @title = "Modifier la mission : #{@mission.title}"
      render :edit
    end
  end

  def destroy
    @mission.destroy
    redirect_to missions_url, notice: 'Mission was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mission
      @mission = Mission.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def mission_params
      params.require(:mission).permit(:title, :description, :small_description, :source_code)
    end
end
