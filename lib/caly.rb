require 'lexer'
require 'parser'
require 'env'

module Caly
  class Runner
    def initialize(exp)
      @exp = exp
      @tokens = Caly::Lexer.new(@exp).call
    end

    def run
      Caly::Parser.new.call(@tokens).map { |e| e.eval(env) }
    end

    def env
      @env ||= Env.new
    end
  end
end
