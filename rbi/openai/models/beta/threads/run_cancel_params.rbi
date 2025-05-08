# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunCancelParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig { returns(String) }
          attr_accessor :thread_id

          sig do
            params(
              thread_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(thread_id:, request_options: {})
          end

          sig do
            override.returns(
              { thread_id: String, request_options: OpenAI::RequestOptions }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
