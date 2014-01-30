class MyMailer < ActionMailer::Base
	def send_email(from,to,subject,body,attach)
		attach.each do |attachment| 
			attachments[attachment.original_filename] = File.read(attachment.tempfile)
		end
		mail(	from: from,
				to: to, 
				subject: subject, 
				body: body	)
		
	end	
	
end