class MyMailer < ActionMailer::Base
	def send_email(from,to,subject,body)
		mail(	from: from,
				to: to, 
				subject: subject, 
				body: body	)
	end	
	
end