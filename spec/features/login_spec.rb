require 'rails_helper'

RSpec.describe "Log In page" do
  it "allows a user to log in to the site when they input their email and password" do
    wayne = User.create(name: "Wayne", email: "partytime@excellent.com", password: "stairwayTOheaven")

    visit "/"
    click_button "Log In"

    expect(current_path).to eq "/login"

    fill_in :email, with: "partytime@excellent.com"
    fill_in :password, with: "stairwayTOheaven"
    click_button "Log In"

    expect(current_path).to eq("/users/#{wayne.id}")
    expect(page).to have_content("Wayne's Dashboard")
  end

  xit "does not allow a user to log in without their correct email or password" do

  end
end