require 'spec_helper'

describe "User pages" do
	subject {page}

	describe "Create New User page" do
		before { visit newuser_path }

		it { should have_content('Create New User')}
		#it { should have_title(full_title('Create New User'))}

		let (:submit) { "Create New User"}

		describe "with invalid information" do
			it "should not create user" do
				expect {click_button submit}.not_to change(User,:count)
			end
		end

		describe "with valid information" do
			before do 
				fill_in "Name", with: "Example"
				fill_in "Email", with: "example@example.com"
			end

			it "should create new user" do
				expect {click_button submit}.to change(User,:count).by(1)
			end
		end



	end

	describe "User profile page" do
		let(:user) { FactoryGirl.create(:user)}
		before {visit user_path(user)}

		it {should have_content(user.name)}
	end

	describe "edit" do
		let(:user) {FactoryGirl.create(:user)}
		before {visit edit_user_path(user) }

		describe "page" do
			it {should have_content("Edit User")}
		end

		describe "with invalid information" do
			before do 
				fill_in "Name", with: ""
				click_button "Edit User"
			end
			it {should have_selector('div.alert.alert-danger')}
		end

		describe "with valid information" do
			let(:new_name) {"New Name"}
			let(:new_email) {"new@example.com"}
			before do 
				fill_in "Name", with: new_name
				fill_in "Email", with: new_email
				click_button "Edit User"
			end					
			specify { expect(user.reload.name).to  eq new_name }
      		specify { expect(user.reload.email).to eq new_email }

      	end
	end

end