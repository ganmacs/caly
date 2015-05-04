module Caly
  class Binary
    def initialize(left, op, right)
      @left = left
      @op = op
      @right = right
    end

    def eval(env)
      r = @right.eval(env)
      if @op.value == '='
        assign(@left.value, r, env)
      else
        l = @left.eval(env)
        l.public_send(@op.value, r)
      end
    end

    def assign(name, r, env)
      env[name] = r
    end
  end

  class Num
    def initialize(token)
      @token = token
    end

    def eval(env)
      Integer(@token.value)
    end
  end

  class Iden
    def initialize(token)
      @token = token
    end

    def value
      @token.value
    end

    def eval(env)
      env[@token.value]
    end
  end
end
