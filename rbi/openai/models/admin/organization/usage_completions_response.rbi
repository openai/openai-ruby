# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class UsageCompletionsResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::UsageCompletionsResponse,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T::Array[
                OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data
              ]
            )
          end
          attr_accessor :data

          sig { returns(T::Boolean) }
          attr_accessor :has_more

          sig { returns(String) }
          attr_accessor :next_page

          sig { returns(Symbol) }
          attr_accessor :object

          sig do
            params(
              data:
                T::Array[
                  OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::OrHash
                ],
              has_more: T::Boolean,
              next_page: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(data:, has_more:, next_page:, object: :page)
          end

          sig do
            override.returns(
              {
                data:
                  T::Array[
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data
                  ],
                has_more: T::Boolean,
                next_page: String,
                object: Symbol
              }
            )
          end
          def to_hash
          end

          class Data < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(Integer) }
            attr_accessor :end_time

            sig { returns(Symbol) }
            attr_accessor :object

            sig do
              returns(
                T::Array[
                  OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::Variants
                ]
              )
            end
            attr_accessor :result

            sig { returns(Integer) }
            attr_accessor :start_time

            sig do
              params(
                end_time: Integer,
                result:
                  T::Array[
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageCompletionsResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageEmbeddingsResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageModerationsResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageImagesResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageVectorStoresResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult::OrHash,
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult::OrHash
                    )
                  ],
                start_time: Integer,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(end_time:, result:, start_time:, object: :bucket)
            end

            sig do
              override.returns(
                {
                  end_time: Integer,
                  object: Symbol,
                  result:
                    T::Array[
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::Variants
                    ],
                  start_time: Integer
                }
              )
            end
            def to_hash
            end

            # The aggregated completions usage details of the specific time bucket.
            module Result
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageCompletionsResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageEmbeddingsResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageModerationsResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageImagesResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageVectorStoresResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult,
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult
                  )
                end

              class OrganizationUsageCompletionsResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageCompletionsResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The aggregated number of text input tokens used, including cached tokens. For
                # customers subscribe to scale tier, this includes scale tier tokens.
                sig { returns(Integer) }
                attr_accessor :input_tokens

                # The count of requests made to the model.
                sig { returns(Integer) }
                attr_accessor :num_model_requests

                sig { returns(Symbol) }
                attr_accessor :object

                # The aggregated number of text output tokens used. For customers subscribe to
                # scale tier, this includes scale tier tokens.
                sig { returns(Integer) }
                attr_accessor :output_tokens

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=batch`, this field tells whether the grouped usage result is
                # batch or not.
                sig { returns(T.nilable(T::Boolean)) }
                attr_accessor :batch

                # The aggregated number of audio input tokens used, including cached tokens.
                sig { returns(T.nilable(Integer)) }
                attr_reader :input_audio_tokens

                sig { params(input_audio_tokens: Integer).void }
                attr_writer :input_audio_tokens

                # The aggregated number of text input tokens that has been cached from previous
                # requests. For customers subscribe to scale tier, this includes scale tier
                # tokens.
                sig { returns(T.nilable(Integer)) }
                attr_reader :input_cached_tokens

                sig { params(input_cached_tokens: Integer).void }
                attr_writer :input_cached_tokens

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # The aggregated number of audio output tokens used.
                sig { returns(T.nilable(Integer)) }
                attr_reader :output_audio_tokens

                sig { params(output_audio_tokens: Integer).void }
                attr_writer :output_audio_tokens

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # When `group_by=service_tier`, this field provides the service tier of the
                # grouped usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :service_tier

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :user_id

                # The aggregated completions usage details of the specific time bucket.
                sig do
                  params(
                    input_tokens: Integer,
                    num_model_requests: Integer,
                    output_tokens: Integer,
                    api_key_id: T.nilable(String),
                    batch: T.nilable(T::Boolean),
                    input_audio_tokens: Integer,
                    input_cached_tokens: Integer,
                    model: T.nilable(String),
                    output_audio_tokens: Integer,
                    project_id: T.nilable(String),
                    service_tier: T.nilable(String),
                    user_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The aggregated number of text input tokens used, including cached tokens. For
                  # customers subscribe to scale tier, this includes scale tier tokens.
                  input_tokens:,
                  # The count of requests made to the model.
                  num_model_requests:,
                  # The aggregated number of text output tokens used. For customers subscribe to
                  # scale tier, this includes scale tier tokens.
                  output_tokens:,
                  # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                  # usage result.
                  api_key_id: nil,
                  # When `group_by=batch`, this field tells whether the grouped usage result is
                  # batch or not.
                  batch: nil,
                  # The aggregated number of audio input tokens used, including cached tokens.
                  input_audio_tokens: nil,
                  # The aggregated number of text input tokens that has been cached from previous
                  # requests. For customers subscribe to scale tier, this includes scale tier
                  # tokens.
                  input_cached_tokens: nil,
                  # When `group_by=model`, this field provides the model name of the grouped usage
                  # result.
                  model: nil,
                  # The aggregated number of audio output tokens used.
                  output_audio_tokens: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  # When `group_by=service_tier`, this field provides the service tier of the
                  # grouped usage result.
                  service_tier: nil,
                  # When `group_by=user_id`, this field provides the user ID of the grouped usage
                  # result.
                  user_id: nil,
                  object: :"organization.usage.completions.result"
                )
                end

                sig do
                  override.returns(
                    {
                      input_tokens: Integer,
                      num_model_requests: Integer,
                      object: Symbol,
                      output_tokens: Integer,
                      api_key_id: T.nilable(String),
                      batch: T.nilable(T::Boolean),
                      input_audio_tokens: Integer,
                      input_cached_tokens: Integer,
                      model: T.nilable(String),
                      output_audio_tokens: Integer,
                      project_id: T.nilable(String),
                      service_tier: T.nilable(String),
                      user_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageEmbeddingsResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageEmbeddingsResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The aggregated number of input tokens used.
                sig { returns(Integer) }
                attr_accessor :input_tokens

                # The count of requests made to the model.
                sig { returns(Integer) }
                attr_accessor :num_model_requests

                sig { returns(Symbol) }
                attr_accessor :object

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :user_id

                # The aggregated embeddings usage details of the specific time bucket.
                sig do
                  params(
                    input_tokens: Integer,
                    num_model_requests: Integer,
                    api_key_id: T.nilable(String),
                    model: T.nilable(String),
                    project_id: T.nilable(String),
                    user_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The aggregated number of input tokens used.
                  input_tokens:,
                  # The count of requests made to the model.
                  num_model_requests:,
                  # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                  # usage result.
                  api_key_id: nil,
                  # When `group_by=model`, this field provides the model name of the grouped usage
                  # result.
                  model: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  # When `group_by=user_id`, this field provides the user ID of the grouped usage
                  # result.
                  user_id: nil,
                  object: :"organization.usage.embeddings.result"
                )
                end

                sig do
                  override.returns(
                    {
                      input_tokens: Integer,
                      num_model_requests: Integer,
                      object: Symbol,
                      api_key_id: T.nilable(String),
                      model: T.nilable(String),
                      project_id: T.nilable(String),
                      user_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageModerationsResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageModerationsResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The aggregated number of input tokens used.
                sig { returns(Integer) }
                attr_accessor :input_tokens

                # The count of requests made to the model.
                sig { returns(Integer) }
                attr_accessor :num_model_requests

                sig { returns(Symbol) }
                attr_accessor :object

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :user_id

                # The aggregated moderations usage details of the specific time bucket.
                sig do
                  params(
                    input_tokens: Integer,
                    num_model_requests: Integer,
                    api_key_id: T.nilable(String),
                    model: T.nilable(String),
                    project_id: T.nilable(String),
                    user_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The aggregated number of input tokens used.
                  input_tokens:,
                  # The count of requests made to the model.
                  num_model_requests:,
                  # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                  # usage result.
                  api_key_id: nil,
                  # When `group_by=model`, this field provides the model name of the grouped usage
                  # result.
                  model: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  # When `group_by=user_id`, this field provides the user ID of the grouped usage
                  # result.
                  user_id: nil,
                  object: :"organization.usage.moderations.result"
                )
                end

                sig do
                  override.returns(
                    {
                      input_tokens: Integer,
                      num_model_requests: Integer,
                      object: Symbol,
                      api_key_id: T.nilable(String),
                      model: T.nilable(String),
                      project_id: T.nilable(String),
                      user_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageImagesResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageImagesResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The number of images processed.
                sig { returns(Integer) }
                attr_accessor :images

                # The count of requests made to the model.
                sig { returns(Integer) }
                attr_accessor :num_model_requests

                sig { returns(Symbol) }
                attr_accessor :object

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # When `group_by=size`, this field provides the image size of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :size

                # When `group_by=source`, this field provides the source of the grouped usage
                # result, possible values are `image.generation`, `image.edit`, `image.variation`.
                sig { returns(T.nilable(String)) }
                attr_accessor :source

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :user_id

                # The aggregated images usage details of the specific time bucket.
                sig do
                  params(
                    images: Integer,
                    num_model_requests: Integer,
                    api_key_id: T.nilable(String),
                    model: T.nilable(String),
                    project_id: T.nilable(String),
                    size: T.nilable(String),
                    source: T.nilable(String),
                    user_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The number of images processed.
                  images:,
                  # The count of requests made to the model.
                  num_model_requests:,
                  # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                  # usage result.
                  api_key_id: nil,
                  # When `group_by=model`, this field provides the model name of the grouped usage
                  # result.
                  model: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  # When `group_by=size`, this field provides the image size of the grouped usage
                  # result.
                  size: nil,
                  # When `group_by=source`, this field provides the source of the grouped usage
                  # result, possible values are `image.generation`, `image.edit`, `image.variation`.
                  source: nil,
                  # When `group_by=user_id`, this field provides the user ID of the grouped usage
                  # result.
                  user_id: nil,
                  object: :"organization.usage.images.result"
                )
                end

                sig do
                  override.returns(
                    {
                      images: Integer,
                      num_model_requests: Integer,
                      object: Symbol,
                      api_key_id: T.nilable(String),
                      model: T.nilable(String),
                      project_id: T.nilable(String),
                      size: T.nilable(String),
                      source: T.nilable(String),
                      user_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageAudioSpeechesResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageAudioSpeechesResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The number of characters processed.
                sig { returns(Integer) }
                attr_accessor :characters

                # The count of requests made to the model.
                sig { returns(Integer) }
                attr_accessor :num_model_requests

                sig { returns(Symbol) }
                attr_accessor :object

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :user_id

                # The aggregated audio speeches usage details of the specific time bucket.
                sig do
                  params(
                    characters: Integer,
                    num_model_requests: Integer,
                    api_key_id: T.nilable(String),
                    model: T.nilable(String),
                    project_id: T.nilable(String),
                    user_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The number of characters processed.
                  characters:,
                  # The count of requests made to the model.
                  num_model_requests:,
                  # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                  # usage result.
                  api_key_id: nil,
                  # When `group_by=model`, this field provides the model name of the grouped usage
                  # result.
                  model: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  # When `group_by=user_id`, this field provides the user ID of the grouped usage
                  # result.
                  user_id: nil,
                  object: :"organization.usage.audio_speeches.result"
                )
                end

                sig do
                  override.returns(
                    {
                      characters: Integer,
                      num_model_requests: Integer,
                      object: Symbol,
                      api_key_id: T.nilable(String),
                      model: T.nilable(String),
                      project_id: T.nilable(String),
                      user_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageAudioTranscriptionsResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageAudioTranscriptionsResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The count of requests made to the model.
                sig { returns(Integer) }
                attr_accessor :num_model_requests

                sig { returns(Symbol) }
                attr_accessor :object

                # The number of seconds processed.
                sig { returns(Integer) }
                attr_accessor :seconds

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                sig { returns(T.nilable(String)) }
                attr_accessor :user_id

                # The aggregated audio transcriptions usage details of the specific time bucket.
                sig do
                  params(
                    num_model_requests: Integer,
                    seconds: Integer,
                    api_key_id: T.nilable(String),
                    model: T.nilable(String),
                    project_id: T.nilable(String),
                    user_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The count of requests made to the model.
                  num_model_requests:,
                  # The number of seconds processed.
                  seconds:,
                  # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                  # usage result.
                  api_key_id: nil,
                  # When `group_by=model`, this field provides the model name of the grouped usage
                  # result.
                  model: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  # When `group_by=user_id`, this field provides the user ID of the grouped usage
                  # result.
                  user_id: nil,
                  object: :"organization.usage.audio_transcriptions.result"
                )
                end

                sig do
                  override.returns(
                    {
                      num_model_requests: Integer,
                      object: Symbol,
                      seconds: Integer,
                      api_key_id: T.nilable(String),
                      model: T.nilable(String),
                      project_id: T.nilable(String),
                      user_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageVectorStoresResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageVectorStoresResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                sig { returns(Symbol) }
                attr_accessor :object

                # The vector stores usage in bytes.
                sig { returns(Integer) }
                attr_accessor :usage_bytes

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # The aggregated vector stores usage details of the specific time bucket.
                sig do
                  params(
                    usage_bytes: Integer,
                    project_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The vector stores usage in bytes.
                  usage_bytes:,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  object: :"organization.usage.vector_stores.result"
                )
                end

                sig do
                  override.returns(
                    {
                      object: Symbol,
                      usage_bytes: Integer,
                      project_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationUsageCodeInterpreterSessionsResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationUsageCodeInterpreterSessionsResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                sig { returns(Symbol) }
                attr_accessor :object

                # The number of code interpreter sessions.
                sig { returns(T.nilable(Integer)) }
                attr_reader :num_sessions

                sig { params(num_sessions: Integer).void }
                attr_writer :num_sessions

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # The aggregated code interpreter sessions usage details of the specific time
                # bucket.
                sig do
                  params(
                    num_sessions: Integer,
                    project_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The number of code interpreter sessions.
                  num_sessions: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # usage result.
                  project_id: nil,
                  object: :"organization.usage.code_interpreter_sessions.result"
                )
                end

                sig do
                  override.returns(
                    {
                      object: Symbol,
                      num_sessions: Integer,
                      project_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end
              end

              class OrganizationCostsResult < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult,
                      OpenAI::Internal::AnyHash
                    )
                  end

                sig { returns(Symbol) }
                attr_accessor :object

                # The monetary value in its associated currency.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult::Amount
                    )
                  )
                end
                attr_reader :amount

                sig do
                  params(
                    amount:
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult::Amount::OrHash
                  ).void
                end
                attr_writer :amount

                # When `group_by=api_key_id`, this field provides the API Key ID of the grouped
                # costs result.
                sig { returns(T.nilable(String)) }
                attr_accessor :api_key_id

                # When `group_by=line_item`, this field provides the line item of the grouped
                # costs result.
                sig { returns(T.nilable(String)) }
                attr_accessor :line_item

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # costs result.
                sig { returns(T.nilable(String)) }
                attr_accessor :project_id

                # The aggregated costs details of the specific time bucket.
                sig do
                  params(
                    amount:
                      OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult::Amount::OrHash,
                    api_key_id: T.nilable(String),
                    line_item: T.nilable(String),
                    project_id: T.nilable(String),
                    object: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The monetary value in its associated currency.
                  amount: nil,
                  # When `group_by=api_key_id`, this field provides the API Key ID of the grouped
                  # costs result.
                  api_key_id: nil,
                  # When `group_by=line_item`, this field provides the line item of the grouped
                  # costs result.
                  line_item: nil,
                  # When `group_by=project_id`, this field provides the project ID of the grouped
                  # costs result.
                  project_id: nil,
                  object: :"organization.costs.result"
                )
                end

                sig do
                  override.returns(
                    {
                      object: Symbol,
                      amount:
                        OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult::Amount,
                      api_key_id: T.nilable(String),
                      line_item: T.nilable(String),
                      project_id: T.nilable(String)
                    }
                  )
                end
                def to_hash
                end

                class Amount < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::OrganizationCostsResult::Amount,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # Lowercase ISO-4217 currency e.g. "usd"
                  sig { returns(T.nilable(String)) }
                  attr_reader :currency

                  sig { params(currency: String).void }
                  attr_writer :currency

                  # The numeric value of the cost.
                  sig { returns(T.nilable(Float)) }
                  attr_reader :value

                  sig { params(value: Float).void }
                  attr_writer :value

                  # The monetary value in its associated currency.
                  sig do
                    params(currency: String, value: Float).returns(
                      T.attached_class
                    )
                  end
                  def self.new(
                    # Lowercase ISO-4217 currency e.g. "usd"
                    currency: nil,
                    # The numeric value of the cost.
                    value: nil
                  )
                  end

                  sig { override.returns({ currency: String, value: Float }) }
                  def to_hash
                  end
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::Admin::Organization::UsageCompletionsResponse::Data::Result::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end
        end
      end
    end
  end
end
