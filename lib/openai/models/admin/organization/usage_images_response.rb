# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Usage#images
        class UsageImagesResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::UsageImagesResponse::Data>]
          required :data,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Admin::Organization::UsageImagesResponse::Data] }

          # @!attribute has_more
          #
          #   @return [Boolean]
          required :has_more, OpenAI::Internal::Type::Boolean

          # @!attribute next_page
          #
          #   @return [String, nil]
          required :next_page, String, nil?: true

          # @!attribute object
          #
          #   @return [Symbol, :page]
          required :object, const: :page

          # @!method initialize(data:, has_more:, next_page:, object: :page)
          #   @param data [Array<OpenAI::Models::Admin::Organization::UsageImagesResponse::Data>]
          #   @param has_more [Boolean]
          #   @param next_page [String, nil]
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

            # @!attribute results
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCompletionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageEmbeddingsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageModerationsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageImagesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioSpeechesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageVectorStoresResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageFileSearchesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageWebSearchesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult>]
            required :results,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result] }

            # @!attribute start_time
            #
            #   @return [Integer]
            required :start_time, Integer

            # @!method initialize(end_time:, results:, start_time:, object: :bucket)
            #   @param end_time [Integer]
            #   @param results [Array<OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCompletionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageEmbeddingsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageModerationsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageImagesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioSpeechesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageVectorStoresResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageFileSearchesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageWebSearchesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult>]
            #   @param start_time [Integer]
            #   @param object [Symbol, :bucket]

            # The aggregated completions usage details of the specific time bucket.
            module Result
              extend OpenAI::Internal::Type::Union

              discriminator :object

              # The aggregated completions usage details of the specific time bucket.
              variant :"organization.usage.completions.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCompletionsResult }

              # The aggregated embeddings usage details of the specific time bucket.
              variant :"organization.usage.embeddings.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageEmbeddingsResult }

              # The aggregated moderations usage details of the specific time bucket.
              variant :"organization.usage.moderations.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageModerationsResult }

              # The aggregated images usage details of the specific time bucket.
              variant :"organization.usage.images.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageImagesResult }

              # The aggregated audio speeches usage details of the specific time bucket.
              variant :"organization.usage.audio_speeches.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioSpeechesResult }

              # The aggregated audio transcriptions usage details of the specific time bucket.
              variant :"organization.usage.audio_transcriptions.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult }

              # The aggregated vector stores usage details of the specific time bucket.
              variant :"organization.usage.vector_stores.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageVectorStoresResult }

              # The aggregated code interpreter sessions usage details of the specific time bucket.
              variant :"organization.usage.code_interpreter_sessions.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult }

              # The aggregated file search calls usage details of the specific time bucket.
              variant :"organization.usage.file_searches.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageFileSearchesResult }

              # The aggregated web search calls usage details of the specific time bucket.
              variant :"organization.usage.web_searches.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageWebSearchesResult }

              # The aggregated costs details of the specific time bucket.
              variant :"organization.costs.result",
                      -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult }

              class OrganizationUsageCompletionsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute input_tokens
                #   The aggregated number of input tokens used, including cached and cache-write
                #   tokens. This includes text, audio, and image tokens. For customers subscribed to
                #   Scale Tier, this includes Scale Tier tokens.
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
                #   The aggregated number of output tokens used across text, audio, and image
                #   outputs. For customers subscribed to Scale Tier, this includes Scale Tier
                #   tokens.
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
                #   The aggregated number of uncached audio input tokens used.
                #
                #   @return [Integer, nil]
                optional :input_audio_tokens, Integer

                # @!attribute input_cache_write_tokens
                #   The aggregated number of input tokens written to the cache.
                #
                #   @return [Integer, nil]
                optional :input_cache_write_tokens, Integer

                # @!attribute input_cached_audio_tokens
                #   The aggregated number of cached audio input tokens used.
                #
                #   @return [Integer, nil]
                optional :input_cached_audio_tokens, Integer

                # @!attribute input_cached_image_tokens
                #   The aggregated number of cached image input tokens used.
                #
                #   @return [Integer, nil]
                optional :input_cached_image_tokens, Integer

                # @!attribute input_cached_text_tokens
                #   The aggregated number of cached text input tokens used.
                #
                #   @return [Integer, nil]
                optional :input_cached_text_tokens, Integer

                # @!attribute input_cached_tokens
                #   The aggregated number of cached input tokens used across text, audio, and image
                #   inputs. For customers subscribed to Scale Tier, this includes Scale Tier tokens.
                #
                #   @return [Integer, nil]
                optional :input_cached_tokens, Integer

                # @!attribute input_image_tokens
                #   The aggregated number of uncached image input tokens used.
                #
                #   @return [Integer, nil]
                optional :input_image_tokens, Integer

                # @!attribute input_text_tokens
                #   The aggregated number of uncached text input tokens used, excluding cache-write
                #   tokens.
                #
                #   @return [Integer, nil]
                optional :input_text_tokens, Integer

                # @!attribute input_uncached_tokens
                #   The aggregated number of uncached input tokens used across text, audio, and
                #   image inputs, excluding cache-write tokens.
                #
                #   @return [Integer, nil]
                optional :input_uncached_tokens, Integer

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

                # @!attribute output_image_tokens
                #   The aggregated number of image output tokens used.
                #
                #   @return [Integer, nil]
                optional :output_image_tokens, Integer

                # @!attribute output_text_tokens
                #   The aggregated number of text output tokens used.
                #
                #   @return [Integer, nil]
                optional :output_text_tokens, Integer

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

                # @!method initialize(input_tokens:, num_model_requests:, output_tokens:, api_key_id: nil, batch: nil, input_audio_tokens: nil, input_cache_write_tokens: nil, input_cached_audio_tokens: nil, input_cached_image_tokens: nil, input_cached_text_tokens: nil, input_cached_tokens: nil, input_image_tokens: nil, input_text_tokens: nil, input_uncached_tokens: nil, model: nil, output_audio_tokens: nil, output_image_tokens: nil, output_text_tokens: nil, project_id: nil, service_tier: nil, user_id: nil, object: :"organization.usage.completions.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCompletionsResult}
                #   for more details.
                #
                #   The aggregated completions usage details of the specific time bucket.
                #
                #   @param input_tokens [Integer] The aggregated number of input tokens used, including cached and cache-write tok
                #
                #   @param num_model_requests [Integer] The count of requests made to the model.
                #
                #   @param output_tokens [Integer] The aggregated number of output tokens used across text, audio, and image output
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param batch [Boolean, nil] When `group_by=batch`, this field tells whether the grouped usage result is batc
                #
                #   @param input_audio_tokens [Integer] The aggregated number of uncached audio input tokens used.
                #
                #   @param input_cache_write_tokens [Integer] The aggregated number of input tokens written to the cache.
                #
                #   @param input_cached_audio_tokens [Integer] The aggregated number of cached audio input tokens used.
                #
                #   @param input_cached_image_tokens [Integer] The aggregated number of cached image input tokens used.
                #
                #   @param input_cached_text_tokens [Integer] The aggregated number of cached text input tokens used.
                #
                #   @param input_cached_tokens [Integer] The aggregated number of cached input tokens used across text, audio, and image
                #
                #   @param input_image_tokens [Integer] The aggregated number of uncached image input tokens used.
                #
                #   @param input_text_tokens [Integer] The aggregated number of uncached text input tokens used, excluding cache-write
                #
                #   @param input_uncached_tokens [Integer] The aggregated number of uncached input tokens used across text, audio, and imag
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param output_audio_tokens [Integer] The aggregated number of audio output tokens used.
                #
                #   @param output_image_tokens [Integer] The aggregated number of image output tokens used.
                #
                #   @param output_text_tokens [Integer] The aggregated number of text output tokens used.
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
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageEmbeddingsResult}
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
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageModerationsResult}
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
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageImagesResult}
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
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioSpeechesResult}
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
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult}
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
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageVectorStoresResult}
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
                # @!attribute num_sessions
                #   The number of code interpreter sessions.
                #
                #   @return [Integer]
                required :num_sessions, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.code_interpreter_sessions.result"]
                required :object, const: :"organization.usage.code_interpreter_sessions.result"

                # @!attribute project_id
                #   When `group_by=project_id`, this field provides the project ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :project_id, String, nil?: true

                # @!method initialize(num_sessions:, project_id: nil, object: :"organization.usage.code_interpreter_sessions.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult}
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

              class OrganizationUsageFileSearchesResult < OpenAI::Internal::Type::BaseModel
                # @!attribute num_requests
                #   The count of file search calls.
                #
                #   @return [Integer]
                required :num_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.file_searches.result"]
                required :object, const: :"organization.usage.file_searches.result"

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

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

                # @!attribute vector_store_id
                #   When `group_by=vector_store_id`, this field provides the vector store ID of the
                #   grouped usage result.
                #
                #   @return [String, nil]
                optional :vector_store_id, String, nil?: true

                # @!method initialize(num_requests:, api_key_id: nil, project_id: nil, user_id: nil, vector_store_id: nil, object: :"organization.usage.file_searches.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageFileSearchesResult}
                #   for more details.
                #
                #   The aggregated file search calls usage details of the specific time bucket.
                #
                #   @param num_requests [Integer] The count of file search calls.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param vector_store_id [String, nil] When `group_by=vector_store_id`, this field provides the vector store ID of the
                #
                #   @param object [Symbol, :"organization.usage.file_searches.result"]
              end

              class OrganizationUsageWebSearchesResult < OpenAI::Internal::Type::BaseModel
                # @!attribute num_model_requests
                #   The count of model requests.
                #
                #   @return [Integer]
                required :num_model_requests, Integer

                # @!attribute num_requests
                #   The count of web search calls.
                #
                #   @return [Integer]
                required :num_requests, Integer

                # @!attribute object
                #
                #   @return [Symbol, :"organization.usage.web_searches.result"]
                required :object, const: :"organization.usage.web_searches.result"

                # @!attribute api_key_id
                #   When `group_by=api_key_id`, this field provides the API key ID of the grouped
                #   usage result.
                #
                #   @return [String, nil]
                optional :api_key_id, String, nil?: true

                # @!attribute context_level
                #   When `group_by=context_level`, this field provides the search context size of
                #   the grouped usage result.
                #
                #   @return [String, nil]
                optional :context_level, String, nil?: true

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

                # @!method initialize(num_model_requests:, num_requests:, api_key_id: nil, context_level: nil, model: nil, project_id: nil, user_id: nil, object: :"organization.usage.web_searches.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageWebSearchesResult}
                #   for more details.
                #
                #   The aggregated web search calls usage details of the specific time bucket.
                #
                #   @param num_model_requests [Integer] The count of model requests.
                #
                #   @param num_requests [Integer] The count of web search calls.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API key ID of the grouped us
                #
                #   @param context_level [String, nil] When `group_by=context_level`, this field provides the search context size of th
                #
                #   @param model [String, nil] When `group_by=model`, this field provides the model name of the grouped usage r
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped us
                #
                #   @param user_id [String, nil] When `group_by=user_id`, this field provides the user ID of the grouped usage re
                #
                #   @param object [Symbol, :"organization.usage.web_searches.result"]
              end

              class OrganizationCostsResult < OpenAI::Internal::Type::BaseModel
                # @!attribute object
                #
                #   @return [Symbol, :"organization.costs.result"]
                required :object, const: :"organization.costs.result"

                # @!attribute amount
                #   The monetary value in its associated currency.
                #
                #   @return [OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult::Amount, nil]
                optional :amount,
                         -> { OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult::Amount }

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

                # @!attribute quantity
                #   When `group_by=line_item`, this field provides the quantity of the grouped costs
                #   result.
                #
                #   @return [Float, nil]
                optional :quantity, Float, nil?: true

                # @!method initialize(amount: nil, api_key_id: nil, line_item: nil, project_id: nil, quantity: nil, object: :"organization.costs.result")
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult}
                #   for more details.
                #
                #   The aggregated costs details of the specific time bucket.
                #
                #   @param amount [OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult::Amount] The monetary value in its associated currency.
                #
                #   @param api_key_id [String, nil] When `group_by=api_key_id`, this field provides the API Key ID of the grouped co
                #
                #   @param line_item [String, nil] When `group_by=line_item`, this field provides the line item of the grouped cost
                #
                #   @param project_id [String, nil] When `group_by=project_id`, this field provides the project ID of the grouped co
                #
                #   @param quantity [Float, nil] When `group_by=line_item`, this field provides the quantity of the grouped costs
                #
                #   @param object [Symbol, :"organization.costs.result"]

                # @see OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult#amount
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
              #   @return [Array(OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCompletionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageEmbeddingsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageModerationsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageImagesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioSpeechesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageVectorStoresResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageFileSearchesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationUsageWebSearchesResult, OpenAI::Models::Admin::Organization::UsageImagesResponse::Data::Result::OrganizationCostsResult)]
            end
          end
        end
      end
    end
  end
end
