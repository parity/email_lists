class EmailProcessor
  def self.process(email)
    @user=User.find_by(email: email.from)
    if !@user.nil?
      #simple
      array = email.to + email.cc       
      #make union (&) between all list addresses and array to get where to resend   
      allmail=List.all.map(&:address).compact.uniq & array
      #make a list of people to send email
      to =[]
      allmail.each do |address|
        elist= List.find_by(address: address)
        elist.users.each do |user|
          if user.email != email.from && !array.include?(user.email)   
            to<<user.email 
          end
        end
      end  
      #send mail
      reply = allmail << email.from  
     	MyMailer.send_email(email.from,to,reply,email.subject,email.raw_body,email.attachments).deliver 
   end	
  end	
end