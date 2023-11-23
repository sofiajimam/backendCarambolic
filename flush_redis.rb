require "redis"

def flush_redis
  redis = Redis.new(host: "localhost", port: 6379)
  redis.flushall
  puts "Redis keys have been cleared."
end

flush_redis
