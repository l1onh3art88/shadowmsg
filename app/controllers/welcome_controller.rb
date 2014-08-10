class WelcomeController < ApplicationController
  def index
  	@message = Message.global_message
  end

  
end
