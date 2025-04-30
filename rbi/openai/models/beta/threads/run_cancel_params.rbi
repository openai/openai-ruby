# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunCancelParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          sig { returns(String) }
          attr_accessor :thread_id

          sig do
            params(
              thread_id: String,
              request_options: T.any(
                OpenAI::RequestOptions,
                OpenAI::Internal::AnyHash
              )
            )
              .returns(T.attached_class)
          end
          def self.new(thread_id:, request_options: {}); end

          sig { override.returns({thread_id: String, request_options: OpenAI::RequestOptions}) }
          def to_hash; end
        end
      end
    end
  end
end
