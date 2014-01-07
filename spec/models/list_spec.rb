require 'spec_helper'

describe List do
  before {@list = List.new(name:"devs", address:"devs@example.com", description:"list for devs")}

  subject { @list }

  it {should respond_to(:name)}
  it {should respond_to(:address)}
  it {should respond_to(:description)}

  it {should be_valid}

  describe "when name is not present" do
  	before {@list.name = ""}
  	it {should_not be_valid}
  end
  
  describe "when name is too long" do
  	before { @list.name = "a"*21}
  	it {should_not be_valid}
  end
  
  describe "when name is already in use" do
	before do
		new_list= @list.dup
		new_list.save
	end		
	it {should_not be_valid}
  end
  
  describe "when name is already in use" do
	before do
		new_list= @list.dup
		new_list.name = @list.name.upcase
		new_list.save
	end		
	it {should_not be_valid}
  end

  describe "when description is too long" do
  	before { @list.name = "a"*51}
  	it {should_not be_valid}
  end

  describe "when address is not present" do
  	before {@list.address=""}
  	it {should_not be_valid}
  end
  
  describe "when address format is invalid" do
	    it "should be invalid" do
	      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
	                     foo@bar_baz.com foo@bar+baz.com]
	      addresses.each do |invalid_address|
	        @list.address = invalid_address
	        expect(@list).not_to be_valid
	      end
	    end
	  end

  describe "when address format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @list.address = valid_address
        expect(@list).to be_valid
      end
    end
  end

  	describe "when list address is already taken" do
	    before do
	      list_with_same_address = @list.dup
	      list_with_same_address.save
	    end

		it { should_not be_valid }
	end

	describe "when list address is already taken" do
	    before do
	      list_with_same_address = @list.dup
	      list_with_same_address.address = @list.address.upcase
	      list_with_same_address.save
	    end

		it { should_not be_valid }
	end	
end
