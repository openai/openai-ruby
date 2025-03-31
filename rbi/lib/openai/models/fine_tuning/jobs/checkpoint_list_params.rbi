# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Jobs
        class CheckpointListParams < OpenAI::BaseModel
          extend OpenAI::Type::RequestParameters::Converter
          include OpenAI::RequestParameters

          # Identifier for the last checkpoint ID from the previous pagination request.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Number of checkpoints to retrieve.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          sig do
            params(
              after: String,
              limit: Integer,
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(after: nil, limit: nil, request_options: {})
          end

          sig { override.returns({after: String, limit: Integer, request_options: OpenAI::RequestOptions}) }
          def to_hash
          end
        end
      end
    end
  end
end
