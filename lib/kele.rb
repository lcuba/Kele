require 'httparty'
require 'json'
require 'lib/roadmap.rb'

class Kele
    include HTTParty
    include JSON
    include Roadmap
   
   
   def initialize(email, password)
       user_info = {body: {email: email, password: password}}
       response = self.class.post(url("sessions"), user_info)
       
       raise "Invalid email or password" unless response.code == 200
       @auth_token = response["auth_token"]
   end
   
   def get_me
       response = self.class.get(url("users/me"), headers: {"authorization" => @auth_token})
       @user = JSON.parse(response.body)
   end
   
   def get_mentor_availability(mentor_id)
      response = self.class.get(url("mentors/#{mentor_id}/student_availability"), headers: {"authorization" => @auth_token})
      @mentor_availability = JSON.parse(response.body)
      print @mentor_availability
   end
   
   def get_messages(arg = nil)
      if arg == nil
        response = self.class.get(url("message_threads"), headers: {"authorization" => @auth_token})
      else
        response = self.class.get(url("message_threads?page=#{arg}"), headers: {"authorization" => @auth_token})
      end
      @messages = JSON.parse(response.body)
   end
   
    def create_message(sender_email, recipient_id, thread_token, subject, message)
        response = self.class.post(url("messages"), 
            body: {
                sender: sender_email,
                recipient_id: recipient_id,
                token: thread_token,
                subject: subject,
                "stripped-text": message},
            headers: {"authorization" => @auth_token})
    end
   
   private
  
   def url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}" 
   end
end