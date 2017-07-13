class EmailProcessor
  def self.process(email)
    @user=User.find_by(email: email.from)
    # simple
    array = (email.to + email.cc + email.bcc).map(&:downcase)  
    # Hard-coded but who cares :P
    allowed_email_lists_from_outside = ["hr@paritycube.com", "finance@paritycube.com", "zingoysupport@paritycube.com"]
    if !@user.nil? || !(array & allowed_email_lists_from_outside).empty?          
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