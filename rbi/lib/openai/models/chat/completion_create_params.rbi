# typed: strong

module OpenAI
  module Models
    module Chat
      class CompletionCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ]
          )
        end
        def messages
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
                OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
                OpenAI::Models::Chat::ChatCompletionUserMessageParam,
                OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
                OpenAI::Models::Chat::ChatCompletionToolMessageParam,
                OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
              )
              ]
            )
        end
        def messages=(_)
        end

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam)) }
        def audio
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam))
        end
        def audio=(_)
        end

        sig { returns(T.nilable(Float)) }
        def frequency_penalty
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def frequency_penalty=(_)
        end

        sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption))) }
        def function_call
        end

        sig do
          params(_: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption))
            .returns(T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption))
        end
        def function_call=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function])) }
        def functions
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function])
            .returns(T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function])
        end
        def functions=(_)
        end

        sig { returns(T.nilable(T::Hash[Symbol, Integer])) }
        def logit_bias
        end

        sig { params(_: T.nilable(T::Hash[Symbol, Integer])).returns(T.nilable(T::Hash[Symbol, Integer])) }
        def logit_bias=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def logprobs
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def logprobs=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_completion_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_completion_tokens=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_tokens=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(T::Array[Symbol])) }
        def modalities
        end

        sig { params(_: T.nilable(T::Array[Symbol])).returns(T.nilable(T::Array[Symbol])) }
        def modalities=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def n
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def n=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def parallel_tool_calls
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def parallel_tool_calls=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent)) }
        def prediction
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent))
        end
        def prediction=(_)
        end

        sig { returns(T.nilable(Float)) }
        def presence_penalty
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def presence_penalty=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def reasoning_effort
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def reasoning_effort=(_)
        end

        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONSchema,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
          )
        end
        def response_format
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            )
          )
            .returns(
              T.any(
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONSchema,
                OpenAI::Models::ResponseFormatJSONObject
              )
            )
        end
        def response_format=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def seed
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def seed=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def service_tier
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def service_tier=(_)
        end

        sig { returns(T.nilable(T.any(String, T::Array[String]))) }
        def stop
        end

        sig do
          params(
            _: T.nilable(
              T.any(
                String,
                T::Array[String]
              )
            )
          ).returns(T.nilable(T.any(String, T::Array[String])))
        end
        def stop=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def store
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def store=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions)) }
        def stream_options
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
            .returns(T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions))
        end
        def stream_options=(_)
        end

        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
        end

        sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice))) }
        def tool_choice
        end

        sig do
          params(_: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice))
            .returns(T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice))
        end
        def tool_choice=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Chat::ChatCompletionTool])) }
        def tools
        end

        sig do
          params(_: T::Array[OpenAI::Models::Chat::ChatCompletionTool])
            .returns(T::Array[OpenAI::Models::Chat::ChatCompletionTool])
        end
        def tools=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def top_logprobs
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def top_logprobs=(_)
        end

        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        sig { returns(T.nilable(String)) }
        def user
        end

        sig { params(_: String).returns(String) }
        def user=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions)) }
        def web_search_options
        end

        sig do
          params(_: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions)
            .returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions)
        end
        def web_search_options=(_)
        end

        sig do
          params(
            messages: T::Array[
            T.any(
              OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
              OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
              OpenAI::Models::Chat::ChatCompletionUserMessageParam,
              OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
              OpenAI::Models::Chat::ChatCompletionToolMessageParam,
              OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
            )
            ],
            model: T.any(String, Symbol),
            audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam),
            frequency_penalty: T.nilable(Float),
            function_call: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption),
            functions: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function],
            logit_bias: T.nilable(T::Hash[Symbol, Integer]),
            logprobs: T.nilable(T::Boolean),
            max_completion_tokens: T.nilable(Integer),
            max_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            modalities: T.nilable(T::Array[Symbol]),
            n: T.nilable(Integer),
            parallel_tool_calls: T::Boolean,
            prediction: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent),
            presence_penalty: T.nilable(Float),
            reasoning_effort: T.nilable(Symbol),
            response_format: T.any(
              OpenAI::Models::ResponseFormatText,
              OpenAI::Models::ResponseFormatJSONSchema,
              OpenAI::Models::ResponseFormatJSONObject
            ),
            seed: T.nilable(Integer),
            service_tier: T.nilable(Symbol),
            stop: T.nilable(T.any(String, T::Array[String])),
            store: T.nilable(T::Boolean),
            stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
            temperature: T.nilable(Float),
            tool_choice: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice),
            tools: T::Array[OpenAI::Models::Chat::ChatCompletionTool],
            top_logprobs: T.nilable(Integer),
            top_p: T.nilable(Float),
            user: String,
            web_search_options: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          messages:,
          model:,
          audio: nil,
          frequency_penalty: nil,
          function_call: nil,
          functions: nil,
          logit_bias: nil,
          logprobs: nil,
          max_completion_tokens: nil,
          max_tokens: nil,
          metadata: nil,
          modalities: nil,
          n: nil,
          parallel_tool_calls: nil,
          prediction: nil,
          presence_penalty: nil,
          reasoning_effort: nil,
          response_format: nil,
          seed: nil,
          service_tier: nil,
          stop: nil,
          store: nil,
          stream_options: nil,
          temperature: nil,
          tool_choice: nil,
          tools: nil,
          top_logprobs: nil,
          top_p: nil,
          user: nil,
          web_search_options: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                messages: T::Array[
                T.any(
                  OpenAI::Models::Chat::ChatCompletionDeveloperMessageParam,
                  OpenAI::Models::Chat::ChatCompletionSystemMessageParam,
                  OpenAI::Models::Chat::ChatCompletionUserMessageParam,
                  OpenAI::Models::Chat::ChatCompletionAssistantMessageParam,
                  OpenAI::Models::Chat::ChatCompletionToolMessageParam,
                  OpenAI::Models::Chat::ChatCompletionFunctionMessageParam
                )
                ],
                model: T.any(String, Symbol),
                audio: T.nilable(OpenAI::Models::Chat::ChatCompletionAudioParam),
                frequency_penalty: T.nilable(Float),
                function_call: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionFunctionCallOption),
                functions: T::Array[OpenAI::Models::Chat::CompletionCreateParams::Function],
                logit_bias: T.nilable(T::Hash[Symbol, Integer]),
                logprobs: T.nilable(T::Boolean),
                max_completion_tokens: T.nilable(Integer),
                max_tokens: T.nilable(Integer),
                metadata: T.nilable(OpenAI::Models::Metadata),
                modalities: T.nilable(T::Array[Symbol]),
                n: T.nilable(Integer),
                parallel_tool_calls: T::Boolean,
                prediction: T.nilable(OpenAI::Models::Chat::ChatCompletionPredictionContent),
                presence_penalty: T.nilable(Float),
                reasoning_effort: T.nilable(Symbol),
                response_format: T.any(
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONSchema,
                  OpenAI::Models::ResponseFormatJSONObject
                ),
                seed: T.nilable(Integer),
                service_tier: T.nilable(Symbol),
                stop: T.nilable(T.any(String, T::Array[String])),
                store: T.nilable(T::Boolean),
                stream_options: T.nilable(OpenAI::Models::Chat::ChatCompletionStreamOptions),
                temperature: T.nilable(Float),
                tool_choice: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice),
                tools: T::Array[OpenAI::Models::Chat::ChatCompletionTool],
                top_logprobs: T.nilable(Integer),
                top_p: T.nilable(Float),
                user: String,
                web_search_options: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Model < OpenAI::Union
          abstract!

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        class FunctionCall < OpenAI::Union
          abstract!

          class FunctionCallMode < OpenAI::Enum
            abstract!

            NONE = :none
            AUTO = :auto

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class << self
            sig { override.returns([[NilClass, Symbol], [NilClass, OpenAI::Models::Chat::ChatCompletionFunctionCallOption]]) }
            private def variants
            end
          end
        end

        class Function < OpenAI::BaseModel
          sig { returns(String) }
          def name
          end

          sig { params(_: String).returns(String) }
          def name=(_)
          end

          sig { returns(T.nilable(String)) }
          def description
          end

          sig { params(_: String).returns(String) }
          def description=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::FunctionParameters)) }
          def parameters
          end

          sig { params(_: OpenAI::Models::FunctionParameters).returns(OpenAI::Models::FunctionParameters) }
          def parameters=(_)
          end

          sig do
            params(name: String, description: String, parameters: OpenAI::Models::FunctionParameters)
              .returns(T.attached_class)
          end
          def self.new(name:, description: nil, parameters: nil)
          end

          sig { override.returns({name: String, description: String, parameters: OpenAI::Models::FunctionParameters}) }
          def to_hash
          end
        end

        class Modality < OpenAI::Enum
          abstract!

          TEXT = :text
          AUDIO = :audio

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class ResponseFormat < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[NilClass, OpenAI::Models::ResponseFormatText], [NilClass, OpenAI::Models::ResponseFormatJSONSchema], [NilClass, OpenAI::Models::ResponseFormatJSONObject]]
                )
            end
            private def variants
            end
          end
        end

        class ServiceTier < OpenAI::Enum
          abstract!

          AUTO = T.let(:auto, T.nilable(Symbol))
          DEFAULT = T.let(:default, T.nilable(Symbol))

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Stop < OpenAI::Union
          abstract!

          StringArray = T.type_alias { T::Array[String] }

          class << self
            sig { override.returns([[NilClass, String], [NilClass, T::Array[String]]]) }
            private def variants
            end
          end
        end

        class WebSearchOptions < OpenAI::BaseModel
          sig { returns(T.nilable(Symbol)) }
          def search_context_size
          end

          sig { params(_: Symbol).returns(Symbol) }
          def search_context_size=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation)) }
          def user_location
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation))
              .returns(T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation))
          end
          def user_location=(_)
          end

          sig do
            params(
              search_context_size: Symbol,
              user_location: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation)
            )
              .returns(T.attached_class)
          end
          def self.new(search_context_size: nil, user_location: nil)
          end

          sig do
            override
              .returns(
                {
                  search_context_size: Symbol,
                  user_location: T.nilable(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation)
                }
              )
          end
          def to_hash
          end

          class SearchContextSize < OpenAI::Enum
            abstract!

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class UserLocation < OpenAI::BaseModel
            sig { returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate) }
            def approximate
            end

            sig do
              params(_: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate)
                .returns(OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate)
            end
            def approximate=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                approximate: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(approximate:, type: :approximate)
            end

            sig do
              override
                .returns(
                  {
                    approximate: OpenAI::Models::Chat::CompletionCreateParams::WebSearchOptions::UserLocation::Approximate,
                    type: Symbol
                  }
                )
            end
            def to_hash
            end

            class Approximate < OpenAI::BaseModel
              sig { returns(T.nilable(String)) }
              def city
              end

              sig { params(_: String).returns(String) }
              def city=(_)
              end

              sig { returns(T.nilable(String)) }
              def country
              end

              sig { params(_: String).returns(String) }
              def country=(_)
              end

              sig { returns(T.nilable(String)) }
              def region
              end

              sig { params(_: String).returns(String) }
              def region=(_)
              end

              sig { returns(T.nilable(String)) }
              def timezone
              end

              sig { params(_: String).returns(String) }
              def timezone=(_)
              end

              sig do
                params(
                  city: String,
                  country: String,
                  region: String,
                  timezone: String
                ).returns(T.attached_class)
              end
              def self.new(city: nil, country: nil, region: nil, timezone: nil)
              end

              sig { override.returns({city: String, country: String, region: String, timezone: String}) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
