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
end




