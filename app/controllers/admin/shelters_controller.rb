class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_by_name
    @shelters_pending = Shelter.pending_app
  end
end
