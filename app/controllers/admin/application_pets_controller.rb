class Admin::ApplicationPetsController < ApplicationController
  def update
    @application = ApplicationPet.find(params[:pet_id])
    @application.update({:approved => "Approved"})
    redirect_to "/admin/applications/#{@application.id}"
  end

  def reject
    @application_reject = ApplicationPet.find(params[:pet_id])
    @application_reject.update({:approved => "Rejected"})
    redirect_to "/admin/applications/#{@application.id}"
  end

end
