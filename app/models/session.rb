class Session

  ADMIN_MAP_KEY = :admin_map

  def initialize(session = nil)
    @session ||= session
  end

  def save(admin_id)
    @session[:admin_id] = admin_id
    old_key = REDIS.hget(ADMIN_MAP_KEY, admin_id)
    REDIS.del(cache_key(old_key)) if old_key
    REDIS.hset(ADMIN_MAP_KEY, admin_id, @session.id)
  end

  def destroy
    REDIS.hdel(ADMIN_MAP_KEY, @session[:admin_id])
    @session.destroy
  end

  private

    def cache_key(sid)
      namespace = Rails.application.config.cache_store[1][:namespace]
      namespace ? "#{namespace}:_session_id:#{sid}" : "_session_id:#{sid}"
    end

    def method_missing(mth, *args, &blk)
      @session.send(mth, *args, &blk)
    end

end