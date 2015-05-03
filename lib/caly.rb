require 'lexer'
require 'parser'

module Caly
  class Runner
    def initialize(exp)
      @exp = exp
      @tokens = Caly::Lexer.new(@exp).call
    end

    def run
      Caly::Parser.new.call(@tokens).eval
    end
  end
end
