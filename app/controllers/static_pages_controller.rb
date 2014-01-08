class StaticPagesController < ApplicationController
  def home
  	@users_count=User.all.count
  	@lists_count=List.all.count
  end
end
