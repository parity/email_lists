class MyMailer < ActionMailer::Base
	def send_email(from,to,reply,subject,body,attach)
		#attach attachments
		attach.each do |attachment| 
			attachments[attachment.original_filename] = File.read(attachment.tempfile)
		end
		mail(	from: from,
				to: to, 
				reply_to: reply,
				subject: subject, 
				body: body	)
		
	end	
	
end