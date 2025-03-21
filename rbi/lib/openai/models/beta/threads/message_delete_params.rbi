# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeleteParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          sig { returns(String) }
          attr_accessor :thread_id

          sig do
            params(thread_id: String, request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash))
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
