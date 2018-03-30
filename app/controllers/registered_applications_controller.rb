class RegisteredApplicationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @registered_applications = RegisteredApplication.where(user: current_user)
  end

  def show
    @registered_application = RegisteredApplication.find(params[:id])
    @events = @registered_application.events.group(:name).count
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = RegisteredApplication.new(registered_application_params)
    @registered_application.user = current_user

    if @registered_application.save
      flash[:notice] = "Application was succesfully saved."
      redirect_to [current_user, @registered_application]
    else
      flash.now[:alert] = "There was an error saving the application. Please try again."
      render :new
    end
  end

  def edit
    @registered_application = RegisteredApplication.find(params[:id])
  end

  def update
    @registered_application = RegisteredApplication.find(params[:id])
    @registered_application.assign_attributes(registered_application_params)

    if @registered_application.save
      flash[:notice] = "Application was succesfully updated."
      redirect_to [current_user, @registered_application]
    else
      flash.now[:alert] = "There was an error updating the application. Please try again."
      render :new
    end
  end

  def destroy
    @registered_application = RegisteredApplication.find(params[:id])

    if @registered_application.destroy
      flash[:notice] = "\"#{@registered_application.name}\" was deleted succesfully."
      redirect_to user_registered_applications_path
    else
      flash.now[:alert] = "There was an error in deleting the application."
      render :show
    end
  end

  private

  def registered_application_params
    params.require(:registered_application).permit(:name, :url)
  end
end
