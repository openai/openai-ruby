# typed: strong

module OpenAI
  module Models
    module Realtime
      class CallCreateResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::CallCreateResponse,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :sdp

        sig { returns(T.nilable(String)) }
        attr_accessor :call_id

        sig { returns(T::Hash[String, String]) }
        attr_accessor :headers

        sig do
          params(
            sdp: String,
            headers: T::Hash[String, String],
            call_id: T.nilable(String)
          ).returns(T.attached_class)
        end
        def self.new(sdp:, headers:, call_id: nil)
        end

        sig do
          override.returns(
            {
              sdp: String,
              call_id: T.nilable(String),
              headers: T::Hash[String, String]
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
