# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class RateLimitUpdateRateLimitParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::RateLimitUpdateRateLimitParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :rate_limit_id

            # The maximum batch input tokens per day. Only relevant for certain models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :batch_1_day_max_input_tokens

            sig { params(batch_1_day_max_input_tokens: Integer).void }
            attr_writer :batch_1_day_max_input_tokens

            # The maximum audio megabytes per minute. Only relevant for certain models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_audio_megabytes_per_1_minute

            sig { params(max_audio_megabytes_per_1_minute: Integer).void }
            attr_writer :max_audio_megabytes_per_1_minute

            # The maximum images per minute. Only relevant for certain models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_images_per_1_minute

            sig { params(max_images_per_1_minute: Integer).void }
            attr_writer :max_images_per_1_minute

            # The maximum requests per day. Only relevant for certain models.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_requests_per_1_day

            sig { params(max_requests_per_1_day: Integer).void }
            attr_writer :max_requests_per_1_day

            # The maximum requests per minute.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_requests_per_1_minute

            sig { params(max_requests_per_1_minute: Integer).void }
            attr_writer :max_requests_per_1_minute

            # The maximum tokens per minute.
            sig { returns(T.nilable(Integer)) }
            attr_reader :max_tokens_per_1_minute

            sig { params(max_tokens_per_1_minute: Integer).void }
            attr_writer :max_tokens_per_1_minute

            sig do
              params(
                project_id: String,
                rate_limit_id: String,
                batch_1_day_max_input_tokens: Integer,
                max_audio_megabytes_per_1_minute: Integer,
                max_images_per_1_minute: Integer,
                max_requests_per_1_day: Integer,
                max_requests_per_1_minute: Integer,
                max_tokens_per_1_minute: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              rate_limit_id:,
              # The maximum batch input tokens per day. Only relevant for certain models.
              batch_1_day_max_input_tokens: nil,
              # The maximum audio megabytes per minute. Only relevant for certain models.
              max_audio_megabytes_per_1_minute: nil,
              # The maximum images per minute. Only relevant for certain models.
              max_images_per_1_minute: nil,
              # The maximum requests per day. Only relevant for certain models.
              max_requests_per_1_day: nil,
              # The maximum requests per minute.
              max_requests_per_1_minute: nil,
              # The maximum tokens per minute.
              max_tokens_per_1_minute: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  rate_limit_id: String,
                  batch_1_day_max_input_tokens: Integer,
                  max_audio_megabytes_per_1_minute: Integer,
                  max_images_per_1_minute: Integer,
                  max_requests_per_1_day: Integer,
                  max_requests_per_1_minute: Integer,
                  max_tokens_per_1_minute: Integer,
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
end
