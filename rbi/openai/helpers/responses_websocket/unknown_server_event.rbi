# typed: strong

module OpenAI
  module Models
    module Responses
      class UnknownServerEvent
        # @api private
        sig do
          params(data: T::Hash[Symbol, T.anything]).returns(T.attached_class)
        end
        def self.new(data:)
        end

        sig { returns(Symbol) }
        attr_reader :type

        sig { returns(T::Hash[Symbol, T.anything]) }
        attr_reader :data

        sig { returns(T.anything) }
        attr_reader :stream_id

        sig { returns(T::Hash[Symbol, T.anything]) }
        def to_h
        end
      end
    end
  end
end
