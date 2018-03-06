module Messaging
   
   def get_messages(page_num = 1)
      response = self.class.get(url("message_threads?page=#{page_num}"), headers: {"authorization" => @auth_token})
      JSON.parse(response.body)
   end
   
    def create_message(sender_email, recipient_id, thread_token, subject, message)
        self.class.post(url("messages"), 
            body: {
                sender: sender_email,
                recipient_id: recipient_id,
                token: thread_token,
                subject: subject,
                "stripped-text": message},
            headers: {"authorization" => @auth_token})
    end
    
end