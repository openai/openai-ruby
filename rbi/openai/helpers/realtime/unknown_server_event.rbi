# typed: strong

module OpenAI
  module Models
    module Realtime
      class UnknownServerEvent
        sig { returns(Symbol) }
        attr_reader :type

        sig { returns(T::Hash[Symbol, T.untyped]) }
        attr_reader :data

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
