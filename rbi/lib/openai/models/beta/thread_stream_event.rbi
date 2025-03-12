# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadStreamEvent < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Beta::Thread) }
        def data
        end

        sig { params(_: OpenAI::Models::Beta::Thread).returns(OpenAI::Models::Beta::Thread) }
        def data=(_)
        end

        sig { returns(Symbol) }
        def event
        end

        sig { params(_: Symbol).returns(Symbol) }
        def event=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def enabled
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def enabled=(_)
        end

        sig { params(data: OpenAI::Models::Beta::Thread, enabled: T::Boolean, event: Symbol).returns(T.attached_class) }
        def self.new(data:, enabled: nil, event: :"thread.created")
        end

        sig { override.returns({data: OpenAI::Models::Beta::Thread, event: Symbol, enabled: T::Boolean}) }
        def to_hash
        end
      end
    end
  end
end
