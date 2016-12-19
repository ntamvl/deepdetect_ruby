require "deepdetect_ruby/version"

module DeepdetectRuby
  module Configuration
    VALID_CONFIG_KEYS = [:host, :host_train, :deepdetect_path, :model_path, :debug, :servers, :is_scaling].freeze
    DEFAULT_HOST = "http://127.0.0.1:8080"
    DEFAULT_HOST_TRAIN = "http://127.0.0.1:8080"

    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def reset
      self.host = DEFAULT_HOST
      self.host_train = DEFAULT_HOST_TRAIN
      self.deepdetect_path = ""
      self.model_path = ""
      self.debug = true
      self.servers = DEFAULT_HOST
      self.is_scaling = false
    end

    def configure
      yield self
    end

    def options
      Hash[* VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten]
    end

  end
end
