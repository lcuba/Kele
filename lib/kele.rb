require 'httparty'
require 'json'
require 'lib/roadmap.rb'
require 'lib/messaging.rb'

class Kele
    include HTTParty
    include JSON
    include Roadmap
    include Messaging
   
   
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
   
   private
  
   def url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}" 
   end
end