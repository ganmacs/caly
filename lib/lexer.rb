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
          token = @exp[i]
          while @exp.size > i + 1 && @exp[i + 1].match(/[0-9]/)
            i += 1
            token += @exp[i]
          end
          result << Token.new(:num, token)
        when /[a-z]/
          token = @exp[i]
          while @exp.size > i + 1 && @exp[i + 1].match(/[a-z0-9]/)
            i += 1
            token += @exp[i]
          end
          result << Token.new(:iden, token)
        when /\n/
          result << Token.new(:eol, @exp[i])
        when /\s+/
        # skip
        when /\(/
          result << Token.new(:lparn, @exp[i])
        when /\)/
          result << Token.new(:rparn, @exp[i])
        when /[\+\-\*\/=]/
          result << Token.new(:op, @exp[i])
        end
        i += 1
      end
      result
    end
  end
end
