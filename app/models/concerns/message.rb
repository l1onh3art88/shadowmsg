class Message
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	attr_accessor  :body, :self_destruct_in_seconds, :to

	def initialize( body = nil, self_destruct_in_seconds = nil)
		
		@body = body
		@self_destruct_in_seconds = self_destruct_in_seconds
	end

	
	def Message.find(id)
		body = REDIS.get id
		expire_in = id.split(":").last.to_i
		if REDIS.get("#{id}:read_flag").nil?
			REDIS.set("#{id}:read_flag", true)
			REDIS.expire id, expire_in
			REDIS.expire "#{id}:read_flag", expire_in
		end
		return body
	end

	def save
		#Telapi::Message.create('{to_number}', '{from_number}', '{body}')
		id = [SecureRandom.hex(14), @self_destruct_in_seconds.to_s].join(":")
		REDIS.set message_key_for(id),self.body
		return message_key_for(id)
	end

	def presisted?
		false
	end

	protected

	def message_key_for(id)
		"messages:#{id}"
	end

end
