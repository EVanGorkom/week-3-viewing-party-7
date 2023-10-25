require 'rails_helper'

RSpec.describe "Log out", type: :feature do
  it "Lets a user log out from any page" do
    wayne = User.create(name: "Wayne", email: "partytime@excellent.com", password: "stairwayTOheaven")

    visit '/login'
    fill_in :email, with: "partytime@excellent.com"
    fill_in :password, with: "stairwayTOheaven"
    click_button "Log In"
    
    visit '/'
    expect(page).to_not have_button("Log In")
    expect(page).to_not have_button("Create New User")
    expect(page).to have_button("Log Out")
    click_button "Log Out"

    expect(current_path).to eq('/')
    expect(page).to have_button("Log In")
    expect(page).to have_button("Create New User")
  end
end