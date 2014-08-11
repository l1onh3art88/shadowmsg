uri = URI.parse(ENV["REDISTOGO_URL"])
REDIS = Redis.new(:host => 'hoki.redistogo.com', :port => 9911, :password => '23d7d203566bda6a96f1a31cbe3d9f1f')