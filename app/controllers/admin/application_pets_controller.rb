class Admin::ApplicationPetsController < ApplicationController
  def update
    @application = ApplicationPet.find(params[:pet_id])
    @application.update({:approved => "Approved"})
    redirect_to "/admin/applications/#{@application.id}"
  end

end
