class EmailProcessor
  def self.process(email)
    #if 'from' in Users.all and 'to' in List.all
    # resend email to Subscription.users
    @user=User.find_by(mail: email.from)
    @list=List.find_by(address: email.to)
    #@subscription = Subscription.find_by(address: @list.email)
    # TO ASK: can we send only to subscribed? 
    if !@user.nil? && !@list.nil? 
    	@to =[]
    	@list.users do |user|
    		@to<<user.email
    	end	
    	MyMailer.send_email(email.from,@to,email.subject,email.body)  
    end	
  end
end