class AddApprovedToApplicationPets < ActiveRecord::Migration[5.2]
  def change
    add_column :application_pets, :approved, :string
  end
end
