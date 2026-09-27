# typed: strong

module OpenAI
  module Models
    module Responses
      class IncrementalResponse
        sig { returns(T.attached_class) }
        def self.new
        end

        sig { returns(T.nilable(Symbol)) }
        attr_reader :phase

        sig { returns(T.nilable(T::Array[T.any(ResponseOutputItem::Variants, T::Hash[Symbol, T.untyped])])) }
        def output
        end

        sig { returns(T.nilable(Connection::ServerEvent)) }
        def terminal_event
        end

        sig { params(event: Connection::ServerEvent).void }
        def add(event)
        end

        sig { void }
        def reset
        end
      end
    end
  end
end
