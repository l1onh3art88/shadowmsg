class MessagesController < ApplicationController

	def new 
		@message = Message.new
	end

	def show
		@message = Message.find(params[:id])
	end

	def create
		@message = Message.new(params[:message][:body], 15)
		message_id = @message.save
		# Telapi::Message.create(params[:message][:to], '+16173263477', "hi, #{current_user.name} sent you a Shadow message, #{message_url(id: message_id)}")
		request_data = { :To => "[+16173263477]", :Body => "hi, #{current_user.name} sent you a Shadow message, #{message_url(id: message_id)}", :Token => ENV['TELAPI_TOKEN'] }
		r = HTTParty.post("https://heroku.telapi.com/send_sms", :body => request_data)
		puts r
		redirect_to :back
	end
end
