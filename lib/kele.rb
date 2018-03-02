require 'httparty'

class Kele
    include HTTParty
   
   
   def initialize(email, password)
       user_info = {body: {email: email, password: password}}
       response = self.class.post(api_url("sessions"), user_info)
       
       raise "Invalid email or password" unless response.code == 200
       @auth_token = response["auth_token"]
   end
   
   private
  
   def api_url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}" 
   end
end