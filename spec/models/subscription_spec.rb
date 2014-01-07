require 'spec_helper'

describe Subscription do

	before {@subscription = FactoryGirl.create(:subscription)}

	subject {@subscription}

	it { should respond_to :user_id }
	it { should respond_to :list_id }
	it { should respond_to :user }
	it { should respond_to :list}
	
end	


