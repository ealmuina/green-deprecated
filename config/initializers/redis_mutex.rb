# Register the Redis server
RedisClassy.redis = Redis.new(url: ENV['JOB_WORKER_URL'])
