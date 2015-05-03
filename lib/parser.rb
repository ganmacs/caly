module Caly
  class Binary
    def initialize(left, op, right)
      @left = left
      @op = op
      @right = right
    end

    def eval
      l = @left.eval
      r = @right.eval
      l.public_send(@op, r)
    end
  end

  class Num
    def initialize(token)
      @token = token
    end

    def eval
      Integer(@token.value)
    end
  end

  class Parser
    def call(tokens)
      @tokens = tokens
      @i = 0
      expr
    end

    # expr = term { (+|-) term }
    def expr
      val = term
      while @tokens.size > @i && %w(+ -).include?(@tokens[@i].value)
        op = @tokens[@i].value
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
        op = @tokens[@i].value
        @i += 1
        val2 = term
        val = Caly::Binary.new(val, op, val2)
      end
      val
    end

    # factor = num | "(" expr ")"
    def factor
      if @tokens[@i].type == :lparn
        @i += 1                 # lparn
        ret = expr
        @i += 1                 # rparn
      else
        ret = num
      end
      ret
    end

    # num = NUM
    def num
      n = Caly::Num.new(@tokens[@i])
      @i += 1
      n
    end
  end
end
