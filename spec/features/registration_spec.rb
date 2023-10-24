require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name, valid password, and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_password, with: 'p@ssw0rd'
    fill_in :user_password_confirmation, with: 'p@ssw0rd'
    fill_in :user_email, with:'user1@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(User.last.password_digest).to_not eq('p@ssw0rd')
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', password: 'p@ssw0rd', email: 'notunique@example.com')

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_password, with: 'p@ssw0rd'
    fill_in :user_password_confirmation, with: 'p@ssw0rd'
    fill_in :user_email, with:'notunique@example.com'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
  end
end
