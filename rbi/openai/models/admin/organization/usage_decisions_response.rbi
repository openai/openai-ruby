# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class UsageDecisionsResponse < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::Admin::Organization::UsageDecisionsResponse,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T::Array[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data]) }
          attr_accessor :data

          sig { returns(T::Boolean) }
          attr_accessor :has_more

          sig { returns(T.nilable(String)) }
          attr_accessor :next_page

          sig { returns(Symbol) }
          attr_accessor :object

          sig do
            params(

              data: T::Array[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::OrHash],

              has_more: T::Boolean,

              next_page: T.nilable(String),

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            data:,

            has_more:,

            next_page:,

            object: :page
          )
          end

          sig do
            override.returns(
              {
                data: T::Array[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data],
                has_more: T::Boolean,
                next_page: T.nilable(String),
                object: Symbol
              }
            )
          end
          def to_hash
          end

          class Data < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Integer) }
            attr_accessor :end_time

            sig { returns(Symbol) }
            attr_accessor :object

            sig { returns(T::Array[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result]) }
            attr_accessor :results

            sig { returns(Integer) }
            attr_accessor :start_time

            sig do
              params(

                end_time: Integer,

                results: T::Array[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::OrHash],

                start_time: Integer,

                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              end_time:,

              results:,

              start_time:,

              object: :bucket
            )
            end

            sig do
              override.returns(
                {
                  end_time: Integer,
                  object: Symbol,
                  results: T::Array[OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result],
                  start_time: Integer
                }
              )
            end
            def to_hash
            end

            class Result < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result,
                  OpenAI::Internal::AnyHash
                )
              end

              # The aggregated number of input tokens used, including cached and cache-write
              # tokens. This includes text, audio, and image tokens. For customers subscribed to
              # Scale Tier, this includes Scale Tier tokens.
              sig { returns(Integer) }
              attr_accessor :input_tokens

              # The count of requests made to the model.
              sig { returns(Integer) }
              attr_accessor :num_model_requests

              sig { returns(Symbol) }
              attr_accessor :object

              # The aggregated number of output tokens used across text, audio, and image
              # outputs. For customers subscribed to Scale Tier, this includes Scale Tier
              # tokens.
              sig { returns(Integer) }
              attr_accessor :output_tokens

              # When `group_by=api_key_id`, this field provides the API key ID of the grouped
              # usage result.
              sig { returns(T.nilable(String)) }
              attr_accessor :api_key_id

              # When grouped by `api_source`, `agents_api` identifies attributed Agents API
              # activity and `unlabeled` includes all records without published source
              # attribution, including historical and unknown origins. Unlabeled does not imply
              # direct API usage. Without source grouping, this field is null.
              sig {
                returns(
                  T.nilable(
                    OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource::TaggedSymbol
                  )
                )
              }
              attr_accessor :api_source

              # When `group_by=batch`, this field tells whether the grouped usage result is
              # batch or not.
              sig { returns(T.nilable(T::Boolean)) }
              attr_accessor :batch

              # The aggregated number of uncached audio input tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_audio_tokens

              # The aggregated number of input tokens written to the cache with a 12-hour
              # retention period.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cache_write_12h_tokens

              # The aggregated number of input tokens written to the cache with a 30-minute
              # retention period.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cache_write_30m_tokens

              # The aggregated number of input tokens written to the cache with a 30-minute
              # retention period.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cache_write_tokens

              # The aggregated number of cached audio input tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cached_audio_tokens

              # The aggregated number of cached image input tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cached_image_tokens

              # The aggregated number of cached text input tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cached_text_tokens

              # The aggregated number of cached input tokens used across text, audio, and image
              # inputs. For customers subscribed to Scale Tier, this includes Scale Tier tokens.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_cached_tokens

              # The aggregated number of uncached image input tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_image_tokens

              # The aggregated number of uncached text input tokens used, excluding cache-write
              # tokens.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_text_tokens

              # The aggregated number of uncached input tokens used across text, audio, and
              # image inputs, excluding cache-write tokens.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :input_uncached_tokens

              # When `group_by=model`, this field provides the model name of the grouped usage
              # result.
              sig { returns(T.nilable(String)) }
              attr_accessor :model

              # The aggregated number of audio output tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :output_audio_tokens

              # The aggregated number of image output tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :output_image_tokens

              # The aggregated number of text output tokens used.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :output_text_tokens

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

              # The aggregated Decisions API usage details of the specific time bucket.
              sig do
                params(

                  input_tokens: Integer,

                  num_model_requests: Integer,

                  output_tokens: Integer,

                  api_key_id: T.nilable(String),

                  api_source: T.nilable(
                    OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource::OrSymbol
                  ),

                  batch: T.nilable(T::Boolean),

                  input_audio_tokens: T.nilable(Integer),

                  input_cache_write_12h_tokens: T.nilable(Integer),

                  input_cache_write_30m_tokens: T.nilable(Integer),

                  input_cache_write_tokens: T.nilable(Integer),

                  input_cached_audio_tokens: T.nilable(Integer),

                  input_cached_image_tokens: T.nilable(Integer),

                  input_cached_text_tokens: T.nilable(Integer),

                  input_cached_tokens: T.nilable(Integer),

                  input_image_tokens: T.nilable(Integer),

                  input_text_tokens: T.nilable(Integer),

                  input_uncached_tokens: T.nilable(Integer),

                  model: T.nilable(String),

                  output_audio_tokens: T.nilable(Integer),

                  output_image_tokens: T.nilable(Integer),

                  output_text_tokens: T.nilable(Integer),

                  project_id: T.nilable(String),

                  service_tier: T.nilable(String),

                  user_id: T.nilable(String),

                  object: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The aggregated number of input tokens used, including cached and cache-write
                # tokens. This includes text, audio, and image tokens. For customers subscribed to
                # Scale Tier, this includes Scale Tier tokens.
                input_tokens:,

                # The count of requests made to the model.
                num_model_requests:,

                # The aggregated number of output tokens used across text, audio, and image
                # outputs. For customers subscribed to Scale Tier, this includes Scale Tier
                # tokens.
                output_tokens:,

                # When `group_by=api_key_id`, this field provides the API key ID of the grouped
                # usage result.
                api_key_id: nil,

                # When grouped by `api_source`, `agents_api` identifies attributed Agents API
                # activity and `unlabeled` includes all records without published source
                # attribution, including historical and unknown origins. Unlabeled does not imply
                # direct API usage. Without source grouping, this field is null.
                api_source: nil,

                # When `group_by=batch`, this field tells whether the grouped usage result is
                # batch or not.
                batch: nil,

                # The aggregated number of uncached audio input tokens used.
                input_audio_tokens: nil,

                # The aggregated number of input tokens written to the cache with a 12-hour
                # retention period.
                input_cache_write_12h_tokens: nil,

                # The aggregated number of input tokens written to the cache with a 30-minute
                # retention period.
                input_cache_write_30m_tokens: nil,

                # The aggregated number of input tokens written to the cache with a 30-minute
                # retention period.
                input_cache_write_tokens: nil,

                # The aggregated number of cached audio input tokens used.
                input_cached_audio_tokens: nil,

                # The aggregated number of cached image input tokens used.
                input_cached_image_tokens: nil,

                # The aggregated number of cached text input tokens used.
                input_cached_text_tokens: nil,

                # The aggregated number of cached input tokens used across text, audio, and image
                # inputs. For customers subscribed to Scale Tier, this includes Scale Tier tokens.
                input_cached_tokens: nil,

                # The aggregated number of uncached image input tokens used.
                input_image_tokens: nil,

                # The aggregated number of uncached text input tokens used, excluding cache-write
                # tokens.
                input_text_tokens: nil,

                # The aggregated number of uncached input tokens used across text, audio, and
                # image inputs, excluding cache-write tokens.
                input_uncached_tokens: nil,

                # When `group_by=model`, this field provides the model name of the grouped usage
                # result.
                model: nil,

                # The aggregated number of audio output tokens used.
                output_audio_tokens: nil,

                # The aggregated number of image output tokens used.
                output_image_tokens: nil,

                # The aggregated number of text output tokens used.
                output_text_tokens: nil,

                # When `group_by=project_id`, this field provides the project ID of the grouped
                # usage result.
                project_id: nil,

                # When `group_by=service_tier`, this field provides the service tier of the
                # grouped usage result.
                service_tier: nil,

                # When `group_by=user_id`, this field provides the user ID of the grouped usage
                # result.
                user_id: nil,

                object: :"organization.usage.decisions.result"
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
                    api_source: T.nilable(
                      OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource::TaggedSymbol
                    ),
                    batch: T.nilable(T::Boolean),
                    input_audio_tokens: T.nilable(Integer),
                    input_cache_write_12h_tokens: T.nilable(Integer),
                    input_cache_write_30m_tokens: T.nilable(Integer),
                    input_cache_write_tokens: T.nilable(Integer),
                    input_cached_audio_tokens: T.nilable(Integer),
                    input_cached_image_tokens: T.nilable(Integer),
                    input_cached_text_tokens: T.nilable(Integer),
                    input_cached_tokens: T.nilable(Integer),
                    input_image_tokens: T.nilable(Integer),
                    input_text_tokens: T.nilable(Integer),
                    input_uncached_tokens: T.nilable(Integer),
                    model: T.nilable(String),
                    output_audio_tokens: T.nilable(Integer),
                    output_image_tokens: T.nilable(Integer),
                    output_text_tokens: T.nilable(Integer),
                    project_id: T.nilable(String),
                    service_tier: T.nilable(String),
                    user_id: T.nilable(String)
                  }
                )
              end
              def to_hash
              end

              # When grouped by `api_source`, `agents_api` identifies attributed Agents API
              # activity and `unlabeled` includes all records without published source
              # attribution, including historical and unknown origins. Unlabeled does not imply
              # direct API usage. Without source grouping, this field is null.
              module APISource
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                AGENTS_API = T.let(
                  :agents_api,
                  OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource::TaggedSymbol
                )
                UNLABELED = T.let(
                  :unlabeled,
                  OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[
                      OpenAI::Models::Admin::Organization::UsageDecisionsResponse::Data::Result::APISource::TaggedSymbol
                    ]
                  )
                }
                def self.values
                end
              end
            end
          end

        end

      end

    end

  end
end
