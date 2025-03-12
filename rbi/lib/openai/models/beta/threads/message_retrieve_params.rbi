# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageRetrieveParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

          sig do
            params(
              thread_id: String,
              request_options: T.any(
                OpenAI::RequestOptions,
                T::Hash[Symbol, T.anything]
              )
            )
              .returns(T.attached_class)
          end
          def self.new(thread_id:, request_options: {})
          end

          sig { override.returns({thread_id: String, request_options: OpenAI::RequestOptions}) }
          def to_hash
          end
        end
      end
    end
  end
end
