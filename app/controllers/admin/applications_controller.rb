class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.all[0]
  end

end
