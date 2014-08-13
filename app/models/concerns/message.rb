class Message
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	attr_accessor  :body, :self_destruct_in_seconds, :to

	def Message.global_message
		REDIS.lrange "global_messages", 0, 4
	end

	def initialize( body = nil, self_destruct_in_seconds = nil)
		
		@body = body
		@self_destruct_in_seconds = self_destruct_in_seconds
		
	end

	#redirect to create message page after login, add a special screen after message has been read, messages show available to unauthenticated users, create a anonymous list of previous 5 messages sent(fixed_array).
	def Message.find(id)
		body = REDIS.get id
		# index = REDIS.append index_key "#{id}"
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
		REDIS.lpush global_messages, self.body
		REDIS.ltrim global_messages, 0, 2
		return message_key_for(id)
	end

	def presisted?
		false
	end

	protected

	def global_messages
		"global_messages"
	end

	def message_key_for(id)
		"messages:#{id}"
	end

end
