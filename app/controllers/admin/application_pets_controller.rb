class Admin::ApplicationPetsController < ApplicationController
  def update
    @applicationpet = ApplicationPet.find(pet_app_params[:pet_id])
    @application = Application.find(@applicationpet.application_id)
    if pet_app_params[:approved] == "Approved"
      @applicationpet.update({:approved => "Approved"})
    else
      @applicationpet.update({:approved => "Rejected"})
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end

private

def pet_app_params
  params.permit(:approved, :pet_id)
end
