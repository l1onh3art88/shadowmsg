class MessagesController < ApplicationController

	def new 
		@message = Message.new
		authorize @message
	end

	def show
		if Message.find(params[:id]).nil?
			redirect_to msg_read_path
		else
			@message = Message.find(params[:id]) 
		end  
	end

	def create
		@message = Message.new(params[:message][:body], params[:message][:self_destruct_in_seconds])
		authorize @message
		message_id = @message.save
		# Telapi::Message.create(params[:message][:to], '+16173263477', "hi, #{current_user.name} sent you a Shadow message, #{message_url(id: message_id)}")
		request_data = { :To => params[:message][:to], :From => "[+16173263477]", :Body => "Hi, #{current_user.name} has sent you a Shadow message, #{message_url(id: message_id)}", :Token => ENV['TELAPI_TOKEN'] }
		r = HTTParty.post("https://heroku.telapi.com/send_sms", :body => request_data)
		
		puts message_id
		redirect_to :back, notice: "Message was sent successfully"

	end
end
