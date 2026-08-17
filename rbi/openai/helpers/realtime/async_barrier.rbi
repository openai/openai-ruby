# typed: strong

# `async` does not publish RBI for this optional-dependency primitive.
module Async
  class Barrier
    sig { void }
    def initialize
    end

    sig do
      params(block: T.proc.returns(T.untyped)).returns(T.untyped)
    end
    def async(&block)
    end

    sig do
      params(block: T.proc.params(task: T.untyped).returns(T.untyped)).returns(
        T.untyped
      )
    end
    def wait(&block)
    end

    sig { void }
    def stop
    end
  end
end
