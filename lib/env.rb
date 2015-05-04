module Caly
  class Env
    def initialize
      @env = {}
    end

    def []=(name, value)
      @env[name] = value
    end

    def [](name)
      @env[name]
    end
  end
end
