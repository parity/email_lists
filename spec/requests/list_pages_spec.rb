require 'spec_helper'

describe "List pages" do

	subject {page}

	describe "create new list" do

		before {visit newlist_path}

		let (:submit) { "Create New List"}

		describe "with bad infos" do
			it "should not create list" do
				expect {click_button submit}.not_to change(List,:count)
			end
		end

		describe "with good infos" do
			before do
				fill_in "Name", with: "example"
				fill_in "Description", with: "Example Description"
				fill_in "Address", with: "mail@example.com"
			end

			it "should create new list" do
				expect {click_button submit}.to change(List,:count).by(1)
			end
		end
	end

	describe "edit list" do
		let(:list) { FactoryGirl.create(:list)}
		before {visit edit_list_path(list)}

		describe "with invalid information" do
			before do 
				fill_in "Name", with: ""
				click_button "Edit List"
			end
			it {should have_selector('div.alert.alert-danger')}

		end

		describe "with good infos" do
			let(:new_name) {"name"}
			let(:new_description) {"description"}
			let(:new_address) {"new@example.com"}
			before do
				fill_in "Name", with: new_name
				fill_in "Description",with: new_description
				fill_in "Address", with: new_address
				click_button "Edit List"
			end
		specify { expect(list.reload.name).to  eq new_name }
      	specify { expect(list.reload.description).to eq new_description }
      	specify { expect(list.reload.address).to  eq new_address}
      end

	end


end




