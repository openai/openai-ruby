# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Usage#code_interpreter_sessions
        class UsageCodeInterpreterSessionsResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data>]
          required :data,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data] }

          # @!attribute has_more
          #
          #   @return [Boolean]
          required :has_more, OpenAI::Internal::Type::Boolean

          # @!attribute next_page
          #
          #   @return [String]
          required :next_page, String

          # @!attribute object
          #
          #   @return [Symbol, :page]
          required :object, const: :page

          # @!method initialize(data:, has_more:, next_page:, object: :page)
          #   @param data [Array<OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data>]
          #   @param has_more [Boolean]
          #   @param next_page [String]
          #   @param object [Symbol, :page]

          class Data < OpenAI::Internal::Type::BaseModel
            # @!attribute end_time
            #
            #   @return [Integer]
            required :end_time, Integer

            # @!attribute object
            #
            #   @return [Symbol, :bucket]
            required :object, const: :bucket

            # @!attribute result
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCompletionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageEmbeddingsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageModerationsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageImagesResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageVectorStoresResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult>]
            required :result,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result] }

            # @!attribute start_time
            #
            #   @return [Integer]
            required :start_time, Integer

            # @!method initialize(end_time:, result:, start_time:, object: :bucket)
            #   @param end_time [Integer]
            #   @param result [Array<OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCompletionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageEmbeddingsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageModerationsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageImagesResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageVectorStoresResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult>]
            #   @param start_time [Integer]
            #   @param object [Symbol, :bucket]

            # The aggregated completions usage details of the specific time bucket.
            module Result
              extend OpenAI::Internal::Type::Union

              discriminator :object

              # The aggregated completions usage details of the specific time bucket.
              variant :"organization.usage.completions.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCompletionsResult }

              # The aggregated embeddings usage details of the specific time bucket.
              variant :"organization.usage.embeddings.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageEmbeddingsResult }

              # The aggregated moderations usage details of the specific time bucket.
              variant :"organization.usage.moderations.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageModerationsResult }

              # The aggregated images usage details of the specific time bucket.
              variant :"organization.usage.images.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageImagesResult }

              # The aggregated audio speeches usage details of the specific time bucket.
              variant :"organization.usage.audio_speeches.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult }

              # The aggregated audio transcriptions usage details of the specific time bucket.
              variant :"organization.usage.audio_transcriptions.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult }

              # The aggregated vector stores usage details of the specific time bucket.
              variant :"organization.usage.vector_stores.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageVectorStoresResult }

              # The aggregated code interpreter sessions usage details of the specific time bucket.
              variant :"organization.usage.code_interpreter_sessions.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult }

              # The aggregated costs details of the specific time bucket.
              variant :"organization.costs.result",
                      -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult }

              class OrganizationUsageCompletionsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute input_tokens
                #   The aggregated number of text input tokens used, including cached tokens. For
                #   customers subscribe to scale tier, this includes scale tier tokens.
                #
                #   @return [Integer]
                required :input_tokens, Integer

                # @!attribute num_model_requests
                #   The count of requests made to the model.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.completions.result"]
                required :object, const: :"organization.usage.completions.result"

                # @!attribute output_tokens
                #   The aggregated number of text output tokens used. For customers subscribe to
                #   scale tier, this includes scale tier tokens.
                #
                #   @return [Integer]
                required :output_tokens, Integer

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute batch
                #   When `group_by=batch`, this field tells whether the grouped usage result is
                #   batch or not.
                #
                #   @return [Boolean, nil]
                optional :batch, OpenAI::Internal::Type::Boolean, nil?: true

                # @!attribute input_audio_tokens
                #   The aggregated number of audio input tokens used, including cached tokens.
                #
                #   @return [Integer, nil]
                optional :input_audio_tokens, Integer

                # @!attribute input_cached_tokens
                #   The aggregated number of text input tokens that has been cached from previous
                #   requests. For customers subscribe to scale tier, this includes scale tier
                #   tokens.
                #
                #   @return [Integer, nil]
                optional :input_cached_tokens, Integer

                # @!attribute model
                #   When `group_by=model`, this field provides the model name of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute output_audio_tokens
                #   The aggregated number of audio output tokens used.
                #
                #   @return [Integer, nil]
                optional :output_audio_tokens, Integer

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!attribute service_tier
                #   When `group_by=service_tier`, this field provides the service tier of the
                #   grouped usage result.
                #
                #   @return [String, nil]
                optional :service_tier, String, nil?: true

                # @!attribute user_id
                #   When `group_by=user_id`, this field provides the user ID of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :user_id, String, nil?: true

                # @!method initialize(input_tokens:, num_model_requests:, output_tokens:, api_key_id: nil, batch: nil, input_audio_tokens: nil, input_cached_tokens: nil, model: nil, output_audio_tokens: nil, project_id: nil, service_tier: nil, user_id: nil, object: :"organization.usage.completions.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCompletionsResult}
                #   for more details.
                #
                #   The aggregated completions usage details of the specific time bucket.
                #
                #   @param input_tokens [Integer] The aggregated number of text input tokens used, including cached tokens. For cu
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param output_tokens [Integer] The aggregated number of text output tokens used. For customers subscribe to sca
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param batch [Boolean, nil] When `group_by=batch`, this field tells whether the grouped usage result is batc
                #
                #   @param input_audio_tokens [Integer] The aggregated number of audio input tokens used, including cached tokens.
                #
                #   @param input_cached_tokens [Integer] The aggregated number of text input tokens that has been cached from previous re
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param output_audio_tokens [Integer] The aggregated number of audio output tokens used.
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param service_tier [String, nil] When `group_by=service_tier`, this field provides the service tier of the groupe
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.completions.result"]
              end

              class OrganizationUsageEmbeddingsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute input_tokens
                #   The aggregated number of input tokens used.
                #
                #   @return [Integer]
                required :input_tokens, Integer

                # @!attribute num_model_requests
                #   The count of requests made to the model.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.embeddings.result"]
                required :object, const: :"organization.usage.embeddings.result"

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute model
                #   When `group_by=model`, this field provides the model name of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!attribute user_id
                #   When `group_by=user_id`, this field provides the user ID of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :user_id, String, nil?: true

                # @!method initialize(input_tokens:, num_model_requests:, api_key_id: nil, model: nil, project_id: nil, user_id: nil, object: :"organization.usage.embeddings.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageEmbeddingsResult}
                #   for more details.
                #
                #   The aggregated embeddings usage details of the specific time bucket.
                #
                #   @param input_tokens [Integer] The aggregated number of input tokens used.
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.embeddings.result"]
              end

              class OrganizationUsageModerationsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute input_tokens
                #   The aggregated number of input tokens used.
                #
                #   @return [Integer]
                required :input_tokens, Integer

                # @!attribute num_model_requests
                #   The count of requests made to the model.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.moderations.result"]
                required :object, const: :"organization.usage.moderations.result"

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute model
                #   When `group_by=model`, this field provides the model name of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!attribute user_id
                #   When `group_by=user_id`, this field provides the user ID of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :user_id, String, nil?: true

                # @!method initialize(input_tokens:, num_model_requests:, api_key_id: nil, model: nil, project_id: nil, user_id: nil, object: :"organization.usage.moderations.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageModerationsResult}
                #   for more details.
                #
                #   The aggregated moderations usage details of the specific time bucket.
                #
                #   @param input_tokens [Integer] The aggregated number of input tokens used.
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.moderations.result"]
              end

              class OrganizationUsageImagesResult < OpenAI::Internal::Type::BaseModel
                # @!attribute images
                #   The number of images processed.
                #
                #   @return [Integer]
                required :images, Integer

                # @!attribute num_model_requests
                #   The count of requests made to the model.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.images.result"]
                required :object, const: :"organization.usage.images.result"

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute model
                #   When `group_by=model`, this field provides the model name of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!attribute size
                #   When `group_by=size`, this field provides the image size of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :size, String, nil?: true

                # @!attribute source
                #   When `group_by=source`, this field provides the source of the grouped usage
                #   result, possible values are `image.generation`, `image.edit`, `image.variation`.
                #
                #   @return [String, nil]
                optional :source, String, nil?: true

                # @!attribute user_id
                #   When `group_by=user_id`, this field provides the user ID of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :user_id, String, nil?: true

                # @!method initialize(images:, num_model_requests:, api_key_id: nil, model: nil, project_id: nil, size: nil, source: nil, user_id: nil, object: :"organization.usage.images.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageImagesResult}
                #   for more details.
                #
                #   The aggregated images usage details of the specific time bucket.
                #
                #   @param images [Integer] The number of images processed.
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param size [String, nil] When `group_by=size`, this field provides the image size of the grouped usage re
                #
                #   @param source [String, nil] When `group_by=source`, this field provides the source of the grouped usage resu
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.images.result"]
              end

              class OrganizationUsageAudioSpeechesResult < OpenAI::Internal::Type::BaseModel
                # @!attribute characters
                #   The number of characters processed.
                #
                #   @return [Integer]
                required :characters, Integer

                # @!attribute num_model_requests
                #   The count of requests made to the model.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.audio_speeches.result"]
                required :object, const: :"organization.usage.audio_speeches.result"

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute model
                #   When `group_by=model`, this field provides the model name of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!attribute user_id
                #   When `group_by=user_id`, this field provides the user ID of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :user_id, String, nil?: true

                # @!method initialize(characters:, num_model_requests:, api_key_id: nil, model: nil, project_id: nil, user_id: nil, object: :"organization.usage.audio_speeches.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult}
                #   for more details.
                #
                #   The aggregated audio speeches usage details of the specific time bucket.
                #
                #   @param characters [Integer] The number of characters processed.
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.audio_speeches.result"]
              end

              class OrganizationUsageAudioTranscriptionsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute num_model_requests
                #   The count of requests made to the model.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.audio_transcriptions.result"]
                required :object, const: :"organization.usage.audio_transcriptions.result"

                # @!attribute seconds
                #   The number of seconds processed.
                #
                #   @return [Integer]
                required :seconds, Integer

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute model
                #   When `group_by=model`, this field provides the model name of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :model, String, nil?: true

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!attribute user_id
                #   When `group_by=user_id`, this field provides the user ID of the grouped usage
                #   result.
                #
                #   @return [String, nil]
                optional :user_id, String, nil?: true

                # @!method initialize(num_model_requests:, seconds:, api_key_id: nil, model: nil, project_id: nil, user_id: nil, object: :"organization.usage.audio_transcriptions.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult}
                #   for more details.
                #
                #   The aggregated audio transcriptions usage details of the specific time bucket.
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param seconds [Integer] The number of seconds processed.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.audio_transcriptions.result"]
              end

              class OrganizationUsageVectorStoresResult < OpenAI::Internal::Type::BaseModel
                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.vector_stores.result"]
                required :object, const: :"organization.usage.vector_stores.result"

                # @!attribute usage_bytes
                #   The vector stores usage in bytes.
                #
                #   @return [Integer]
                required :usage_bytes, Integer

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!method initialize(usage_bytes:, project_id: nil, object: :"organization.usage.vector_stores.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageVectorStoresResult}
                #   for more details.
                #
                #   The aggregated vector stores usage details of the specific time bucket.
                #
                #   @param usage_bytes [Integer] The vector stores usage in bytes.
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param object [Symbol, :"organization.usage.vector_stores.result"]
              end

              class OrganizationUsageCodeInterpreterSessionsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.code_interpreter_sessions.result"]
                required :object, const: :"organization.usage.code_interpreter_sessions.result"

                # @!attribute num_sessions
                #   The number of code interpreter sessions.
                #
                #   @return [Integer, nil]
                optional :num_sessions, Integer

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!method initialize(num_sessions: nil, project_id: nil, object: :"organization.usage.code_interpreter_sessions.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult}
                #   for more details.
                #
                #   The aggregated code interpreter sessions usage details of the specific time
                #   bucket.
                #
                #   @param num_sessions [Integer] The number of code interpreter sessions.
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param object [Symbol, :"organization.usage.code_interpreter_sessions.result"]
              end

              class OrganizationCostsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute object
                #
                #   @return [Symbol, :"organization.costs.result"]
                required :object, const: :"organization.costs.result"

                # @!attribute amount
                #   The monetary value in its associated currency.
                #
                #   @return [OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult::Amount, nil]
                optional :amount,
                         -> { OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult::Amount }

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API Key ID of the grouped
                #   costs result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute line_item
                #   When `group_by=line_item`, this field provides the line item of the grouped
                #   costs result.
                #
                #   @return [String, nil]
                optional :line_item, String, nil?: true

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   costs result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!method initialize(amount: nil, api_key_id: nil, line_item: nil, project_id: nil, object: :"organization.costs.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult}
                #   for more details.
                #
                #   The aggregated costs details of the specific time bucket.
                #
                #   @param amount [OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult::Amount] The monetary value in its associated currency.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API Key ID of the grouped co
                #
                #   @param line_item [String, nil] When `group_by=line_item`, this field provides the line item of the grouped cost
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped co
                #
                #   @param object [Symbol, :"organization.costs.result"]

                # @see OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult#amount
                class Amount < OpenAI::Internal::Type::BaseModel
                  # @!attribute currency
                  #   Lowercase ISO-4217 currency e.g. "usd"
                  #
                  #   @return [String, nil]
                  optional :currency, String

                  # @!attribute value
                  #   The numeric value of the cost.
                  #
                  #   @return [Float, nil]
                  optional :value, Float

                  # @!method initialize(currency: nil, value: nil)
                  #   The monetary value in its associated currency.
                  #
                  #   @param currency [String] Lowercase ISO-4217 currency e.g. "usd"
                  #
                  #   @param value [Float] The numeric value of the cost.
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCompletionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageEmbeddingsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageModerationsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageImagesResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageVectorStoresResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult, OpenAI::Models::Admin::Organization::UsageCodeInterpreterSessionsResponse::Data::Result::OrganizationCostsResult)]
            end
          end
        end
      end
    end
  end
end
