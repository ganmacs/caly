module Caly
  Token = Struct.new('Token', :type, :value)

  class Lexer
    def initialize(exp)
      @exp = exp
    end

    def call
      i = 0
      result = []

      while @exp.size > i
        case @exp[i]
        when /[0-9]/
          token = ''
          while @exp.size > i && @exp[i].match(/[0-9]/)
            token += @exp[i]
            i += 1
          end
          result << Token.new(:num, token)
        when /\s+/
        # skip
        when /\(/
          result << Token.new(:lparn, @exp[i])
        when /\)/
          result << Token.new(:rparn, @exp[i])
        when /[\+\-\*\/]/
          result << Token.new(:op, @exp[i])
        end
        i += 1
      end
      result
    end
  end
end
