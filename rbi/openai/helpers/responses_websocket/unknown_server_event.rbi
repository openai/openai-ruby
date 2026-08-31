# typed: strong

module OpenAI
  module Models
    module Responses
      class UnknownServerEvent
        # @api private
        sig do
          params(data: T::Hash[Symbol, T.untyped]).returns(T.attached_class)
        end
        def self.new(data:)
        end

        sig { returns(Symbol) }
        attr_reader :type

        sig { returns(T::Hash[Symbol, T.untyped]) }
        attr_reader :data

        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def to_h
        end
      end
    end
  end
end
