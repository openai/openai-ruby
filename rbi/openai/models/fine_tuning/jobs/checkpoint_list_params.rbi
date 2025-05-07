# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Jobs
        class CheckpointListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the last checkpoint ID from the previous pagination request.
            after: nil,
            # Number of checkpoints to retrieve.
            limit: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: String,
                limit: Integer,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
