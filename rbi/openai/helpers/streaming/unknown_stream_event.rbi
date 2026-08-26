# typed: strong

module OpenAI
  module Helpers
    module Streaming
      class UnknownStreamEvent
        sig { returns(Symbol) }
        attr_reader :type

        sig { returns(T.nilable(Integer)) }
        attr_reader :sequence_number

        sig { returns(T::Hash[Symbol, T.untyped]) }
        attr_reader :data

        # @api private
        sig do
          params(data: T::Hash[Symbol, T.untyped]).returns(T.attached_class)
        end
        def self.new(data:)
        end

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_h
        end
      end
    end
  end
end
