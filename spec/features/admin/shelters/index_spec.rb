require 'rails_helper'


RSpec.describe 'the admin/shelter index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  end

  it ' It shows all shelters listed in reverse alphabetical orders by name' do
     visit "/admin/shelters"

     expect(page).to have_content(@shelter_2.name)
     expect(@shelter_2.name).to appear_before(@shelter_3.name)
     expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it ' It shows all shelters with pending applications' do
    application = Application.create!(name: 'David',street: '1023 Makeup',city: 'Chicago', state: 'IL', zip: '60657', description: 'Great Person', status: "Pending")
    application_2 = Application.create!(name: 'Jim', street: '123 Hello St', city: 'Denver', state: 'CO', zip: '80211', description: 'Great Person', status: "Pending")
    pet_application = ApplicationPet.create!(pet_id: @pet_1.id, application_id: application.id)
    pet_application_2 = ApplicationPet.create!(pet_id: @pet_3.id, application_id: application_2.id)

     visit "/admin/shelters"

     expect(page).to have_content(@shelter_1.name)
     expect(page).to have_content(@shelter_3.name)
  end
end
