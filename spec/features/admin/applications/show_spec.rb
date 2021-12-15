require 'rails_helper'


RSpec.describe 'the admin/applications show' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

  end

  it 'has every pet that there is an application for and an approve button' do
    application = Application.create!(name: 'David',street: '1023 Makeup',city: 'Chicago', state: 'IL', zip: '60657', description: 'Great Person', status: "Pending")
    pet_application = ApplicationPet.create!(pet_id: @pet_1.id, application_id: application.id)
    visit "/admin/applications/#{pet_application.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_button("Approve")

  end

  it 'press approve and removes approve button and we see approved next to pet name' do
    application = Application.create!(name: 'David',street: '1023 Makeup',city: 'Chicago', state: 'IL', zip: '60657', description: 'Great Person', status: "Pending")

    pet_application = ApplicationPet.create!(pet_id: @pet_1.id, application_id: application.id)
    visit "/admin/applications/#{pet_application.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_button("Approve")
    click_on ("Approve")

    expect(current_path).to eq("/admin/applications/#{pet_application.id}")

    expect(page).to_not have_button("Approve")
    expect(page).to have_content("Approved")
  end

  it 'press reject and removes approve and reject button and we see reject next to pet name' do

    application_2 = Application.create!(name: 'Jim', street: '123 Hello St', city: 'Denver', state: 'CO', zip: '80211', description: 'Great Person', status: "Pending")
    pet_application_2 = ApplicationPet.create!(pet_id: @pet_3.id, application_id: application_2.id)

    visit "/admin/applications/#{pet_application_2.id}"

    expect(page).to have_content(@pet_3.name)
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
    click_on ("Reject")

    expect(current_path).to eq("/admin/applications/#{pet_application_2.id}")

    
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("Rejected")
  end

end
