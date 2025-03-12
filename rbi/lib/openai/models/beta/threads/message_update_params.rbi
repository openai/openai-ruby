# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageUpdateParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          sig do
            params(
              thread_id: String,
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
            )
              .returns(T.attached_class)
          end
          def self.new(thread_id:, metadata: nil, request_options: {})
          end

          sig do
            override
              .returns(
                {thread_id: String, metadata: T.nilable(OpenAI::Models::Metadata), request_options: OpenAI::RequestOptions}
              )
          end
          def to_hash
          end
        end
      end
    end
  end
end
