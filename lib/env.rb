require 'Forwardable'

module Caly
  class Env
    extend Forwardable
    def_delegators :@env, :[]=, []

    def initialize
      @env = {}
    end
  end
end
