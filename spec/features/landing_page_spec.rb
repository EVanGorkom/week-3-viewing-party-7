require 'rails_helper'

RSpec.describe 'Landing Page' do
  before :each do 
    user1 = User.create(name: "User One", password: "p@ssw0rd", password_confirmation: "p@ssw0rd", email: "user1@test.com")
    user2 = User.create(name: "User Two", password: "p@ssw0rd", password_confirmation: "p@ssw0rd", email: "user2@test.com")
    visit '/'
  end 

  it 'has a header' do
    expect(page).to have_content('Viewing Party Lite')
  end

  it 'has links/buttons that link to correct pages' do 
    click_button "Create New User"
    
    expect(current_path).to eq(register_path) 
    
    visit '/'
    click_link "Home"

    expect(current_path).to eq(root_path)
  end 

  it 'lists out existing users' do 
    user1 = User.create(name: "User One", email: "user1@test.com")
    user2 = User.create(name: "User Two", email: "user2@test.com")

    expect(page).to have_content('Existing Users:')

    within('.existing-users') do 
      expect(page).to have_content(user1.email)
      expect(page).to have_content(user2.email)
    end     
  end 

  it 'prevents a user from accessing routes without logging in' do
    wayne = User.create(name: "Wayne", email: "partytime@excellent.com", password: "stairwayTOheaven")

    visit '/'
    visit "/users/#{wayne.id}"

    expect(current_path).to eq('/')
    expect(page).to have_content("You need to log in to access this page.")
  end
end
