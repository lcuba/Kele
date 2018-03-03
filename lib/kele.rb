require 'httparty'
require 'json'

class Kele
    include HTTParty
    include JSON
   
   
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
   
   private
  
   def url(endpoint)
      "https://www.bloc.io/api/v1/#{endpoint}" 
   end
end