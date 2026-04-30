# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectRateLimit = Projects::ProjectRateLimit

        module Projects
          class ProjectRateLimit < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectRateLimit,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints.
            sig { returns(String) }
            attr_accessor :id

            # The maximum requests per minute.
            sig { returns(Integer) }
            attr_accessor :max_requests_per_1_minute

            # The maximum tokens per minute.
            sig { returns(Integer) }
            attr_accessor :max_tokens_per_1_minute

            # The model this rate limit applies to.
            sig { returns(String) }
            attr_accessor :model

            # The object type, which is always `project.rate_limit`
            sig { returns(Symbol) }
            attr_accessor :object

            # The maximum batch input tokens per day. Only present for relevant models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :batch_1_day_max_input_tokens

            sig { params(batch_1_day_max_input_tokens: Integer).void }
            attr_writer :batch_1_day_max_input_tokens

            # The maximum audio megabytes per minute. Only present for relevant models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_audio_megabytes_per_1_minute

            sig { params(max_audio_megabytes_per_1_minute: Integer).void }
            attr_writer :max_audio_megabytes_per_1_minute

            # The maximum images per minute. Only present for relevant models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_images_per_1_minute

            sig { params(max_images_per_1_minute: Integer).void }
            attr_writer :max_images_per_1_minute

            # The maximum requests per day. Only present for relevant models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_requests_per_1_day

            sig { params(max_requests_per_1_day: Integer).void }
            attr_writer :max_requests_per_1_day

            # Represents a project rate limit config.
            sig do
              params(
                id: String,
                max_requests_per_1_minute: Integer,
                max_tokens_per_1_minute: Integer,
                model: String,
                batch_1_day_max_input_tokens: Integer,
                max_audio_megabytes_per_1_minute: Integer,
                max_images_per_1_minute: Integer,
                max_requests_per_1_day: Integer,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints.
              id:,
              # The maximum requests per minute.
              max_requests_per_1_minute:,
              # The maximum tokens per minute.
              max_tokens_per_1_minute:,
              # The model this rate limit applies to.
              model:,
              # The maximum batch input tokens per day. Only present for relevant models.
              batch_1_day_max_input_tokens: nil,
              # The maximum audio megabytes per minute. Only present for relevant models.
              max_audio_megabytes_per_1_minute: nil,
              # The maximum images per minute. Only present for relevant models.
              max_images_per_1_minute: nil,
              # The maximum requests per day. Only present for relevant models.
              max_requests_per_1_day: nil,
              # The object type, which is always `project.rate_limit`
              object: :"project.rate_limit"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  max_requests_per_1_minute: Integer,
                  max_tokens_per_1_minute: Integer,
                  model: String,
                  object: Symbol,
                  batch_1_day_max_input_tokens: Integer,
                  max_audio_megabytes_per_1_minute: Integer,
                  max_images_per_1_minute: Integer,
                  max_requests_per_1_day: Integer
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
end
