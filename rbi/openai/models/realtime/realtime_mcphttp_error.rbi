# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeMcphttpError < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeMcphttpError,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(Integer) }
        attr_accessor :code

        sig { returns(String) }
        attr_accessor :message

        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(code: Integer, message: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(code:, message:, type: :http_error)
        end

        sig do
          override.returns({ code: Integer, message: String, type: Symbol })
        end
        def to_hash
        end
      end
    end
  end
end
