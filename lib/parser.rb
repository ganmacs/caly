require 'ast'

module Caly
  class Parser
    def call(tokens)
      @tokens = tokens
      @i = 0
      ret = []
      ret << state while @tokens.size > @i
      ret
    end

    # state = IDEN "=" expr EOL | expr EOL
    def state
      iden = nil
      op = nil
      if @tokens[@i].type == :iden
        iden = Caly::Iden.new(@tokens[@i])
        @i += 1
        op = @tokens[@i]
        @i += 1
      end
      val2 = expr
      @i += 1                   # eol

      if iden.nil?
        val2
      else
        Caly::Binary.new(iden, op, val2)
      end
    end

    # expr = term { (+|-) term }
    def expr
      val = term
      while @tokens.size > @i && %w(+ -).include?(@tokens[@i].value)
        op = @tokens[@i]
        @i += 1
        val2 = term
        val = Caly::Binary.new(val, op, val2)
      end
      val
    end

    # term = factor { (*|/) factor }
    def term
      val = factor
      while @tokens.size > @i && %w(* /).include?(@tokens[@i].value)
        op = @tokens[@i]
        @i += 1
        val2 = term
        val = Caly::Binary.new(val, op, val2)
      end
      val
    end

    # factor = num | iden | "(" expr ")"
    def factor
      if @tokens[@i].type == :lparn
        @i += 1                 # lparn
        ret = expr
        @i += 1                 # rparn
      elsif @tokens[@i].type == :iden
        ret = iden
      else
        ret = num
      end
      ret
    end

    # iden = IDEN
    def iden
      n = Caly::Iden.new(@tokens[@i])
      @i += 1
      n
    end

    # num = NUM
    def num
      n = Caly::Num.new(@tokens[@i])
      @i += 1
      n
    end
  end
end
