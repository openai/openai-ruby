# typed: strong

module OpenAI
  module Models
    module Beta
      class ResponseCompactParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::ResponseCompactParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::ResponseCompactParams::Model::OrSymbol,
                String
              )
            )
          )
        end
        attr_accessor :model

        # Text, image, or file inputs to the model, used to generate a response
        sig do
          returns(
            T.nilable(OpenAI::Beta::ResponseCompactParams::Input::Variants)
          )
        end
        attr_accessor :input

        # A system (or developer) message inserted into the model's context. When used
        # along with `previous_response_id`, the instructions from a previous response
        # will not be carried over to the next response. This makes it simple to swap out
        # system (or developer) messages in new responses.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        # Cannot be used in conjunction with `conversation`.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_response_id

        # A key to use when reading from or writing to the prompt cache.
        sig { returns(T.nilable(String)) }
        attr_accessor :prompt_cache_key

        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
        # for current details.
        sig do
          returns(
            T.nilable(OpenAI::Beta::ResponseCompactParams::PromptCacheOptions)
          )
        end
        attr_reader :prompt_cache_options

        sig do
          params(
            prompt_cache_options:
              T.nilable(
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::OrHash
              )
          ).void
        end
        attr_writer :prompt_cache_options

        # How long to retain a prompt cache entry created by this request.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::ResponseCompactParams::PromptCacheRetention::OrSymbol
            )
          )
        end
        attr_accessor :prompt_cache_retention

        # The service tier to use for this request.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::ResponseCompactParams::ServiceTier::OrSymbol
            )
          )
        end
        attr_accessor :service_tier

        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Beta::ResponseCompactParams::Beta::OrSymbol]
            )
          )
        end
        attr_reader :betas

        sig do
          params(
            betas: T::Array[OpenAI::Beta::ResponseCompactParams::Beta::OrSymbol]
          ).void
        end
        attr_writer :betas

        sig do
          params(
            model:
              T.nilable(
                T.any(
                  OpenAI::Beta::ResponseCompactParams::Model::OrSymbol,
                  String
                )
              ),
            input:
              T.nilable(OpenAI::Beta::ResponseCompactParams::Input::Variants),
            instructions: T.nilable(String),
            previous_response_id: T.nilable(String),
            prompt_cache_key: T.nilable(String),
            prompt_cache_options:
              T.nilable(
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::OrHash
              ),
            prompt_cache_retention:
              T.nilable(
                OpenAI::Beta::ResponseCompactParams::PromptCacheRetention::OrSymbol
              ),
            service_tier:
              T.nilable(
                OpenAI::Beta::ResponseCompactParams::ServiceTier::OrSymbol
              ),
            betas:
              T::Array[OpenAI::Beta::ResponseCompactParams::Beta::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          model:,
          # Text, image, or file inputs to the model, used to generate a response
          input: nil,
          # A system (or developer) message inserted into the model's context. When used
          # along with `previous_response_id`, the instructions from a previous response
          # will not be carried over to the next response. This makes it simple to swap out
          # system (or developer) messages in new responses.
          instructions: nil,
          # The unique ID of the previous response to the model. Use this to create
          # multi-turn conversations. Learn more about
          # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
          # Cannot be used in conjunction with `conversation`.
          previous_response_id: nil,
          # A key to use when reading from or writing to the prompt cache.
          prompt_cache_key: nil,
          # Options for prompt caching. Supported for `gpt-5.6` and later models. By
          # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
          # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
          # request can write up to four breakpoints. For cache matching, OpenAI considers
          # up to the latest 80 breakpoints in the conversation, without a content-block
          # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
          # `ttl` defaults to `30m`, which is currently the only supported value. See the
          # [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
          # for current details.
          prompt_cache_options: nil,
          # How long to retain a prompt cache entry created by this request.
          prompt_cache_retention: nil,
          # The service tier to use for this request.
          service_tier: nil,
          betas: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              model:
                T.nilable(
                  T.any(
                    OpenAI::Beta::ResponseCompactParams::Model::OrSymbol,
                    String
                  )
                ),
              input:
                T.nilable(OpenAI::Beta::ResponseCompactParams::Input::Variants),
              instructions: T.nilable(String),
              previous_response_id: T.nilable(String),
              prompt_cache_key: T.nilable(String),
              prompt_cache_options:
                T.nilable(
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions
                ),
              prompt_cache_retention:
                T.nilable(
                  OpenAI::Beta::ResponseCompactParams::PromptCacheRetention::OrSymbol
                ),
              service_tier:
                T.nilable(
                  OpenAI::Beta::ResponseCompactParams::ServiceTier::OrSymbol
                ),
              betas:
                T::Array[OpenAI::Beta::ResponseCompactParams::Beta::OrSymbol],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol,
                String
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCompactParams::Model::Variants]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseCompactParams::Model)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_5_6_SOL =
            T.let(
              :"gpt-5.6-sol",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_6_TERRA =
            T.let(
              :"gpt-5.6-terra",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_6_LUNA =
            T.let(
              :"gpt-5.6-luna",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_4 =
            T.let(
              :"gpt-5.4",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_4_MINI =
            T.let(
              :"gpt-5.4-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_4_NANO =
            T.let(
              :"gpt-5.4-nano",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_4_MINI_2026_03_17 =
            T.let(
              :"gpt-5.4-mini-2026-03-17",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_4_NANO_2026_03_17 =
            T.let(
              :"gpt-5.4-nano-2026-03-17",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_3_CHAT_LATEST =
            T.let(
              :"gpt-5.3-chat-latest",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2 =
            T.let(
              :"gpt-5.2",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2_2025_12_11 =
            T.let(
              :"gpt-5.2-2025-12-11",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2_CHAT_LATEST =
            T.let(
              :"gpt-5.2-chat-latest",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2_PRO =
            T.let(
              :"gpt-5.2-pro",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2_PRO_2025_12_11 =
            T.let(
              :"gpt-5.2-pro-2025-12-11",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1 =
            T.let(
              :"gpt-5.1",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_2025_11_13 =
            T.let(
              :"gpt-5.1-2025-11-13",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_CODEX =
            T.let(
              :"gpt-5.1-codex",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_MINI =
            T.let(
              :"gpt-5.1-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_CHAT_LATEST =
            T.let(
              :"gpt-5.1-chat-latest",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5 =
            T.let(
              :"gpt-5",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_MINI =
            T.let(
              :"gpt-5-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_NANO =
            T.let(
              :"gpt-5-nano",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2025_08_07 =
            T.let(
              :"gpt-5-2025-08-07",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_MINI_2025_08_07 =
            T.let(
              :"gpt-5-mini-2025-08-07",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_NANO_2025_08_07 =
            T.let(
              :"gpt-5-nano-2025-08-07",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_CHAT_LATEST =
            T.let(
              :"gpt-5-chat-latest",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1 =
            T.let(
              :"gpt-4.1",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_MINI =
            T.let(
              :"gpt-4.1-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_NANO =
            T.let(
              :"gpt-4.1-nano",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_2025_04_14 =
            T.let(
              :"gpt-4.1-2025-04-14",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_MINI_2025_04_14 =
            T.let(
              :"gpt-4.1-mini-2025-04-14",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_NANO_2025_04_14 =
            T.let(
              :"gpt-4.1-nano-2025-04-14",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI =
            T.let(
              :"o4-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI_2025_04_16 =
            T.let(
              :"o4-mini-2025-04-16",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3 =
            T.let(:o3, OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol)
          O3_2025_04_16 =
            T.let(
              :"o3-2025-04-16",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_MINI =
            T.let(
              :"o3-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_MINI_2025_01_31 =
            T.let(
              :"o3-mini-2025-01-31",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1 =
            T.let(:o1, OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol)
          O1_2024_12_17 =
            T.let(
              :"o1-2024-12-17",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PREVIEW =
            T.let(
              :"o1-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PREVIEW_2024_09_12 =
            T.let(
              :"o1-preview-2024-09-12",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_MINI =
            T.let(
              :"o1-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_MINI_2024_09_12 =
            T.let(
              :"o1-mini-2024-09-12",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O =
            T.let(
              :"gpt-4o",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_2024_11_20 =
            T.let(
              :"gpt-4o-2024-11-20",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_2024_08_06 =
            T.let(
              :"gpt-4o-2024-08-06",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_2024_05_13 =
            T.let(
              :"gpt-4o-2024-05-13",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW =
            T.let(
              :"gpt-4o-audio-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2024_10_01 =
            T.let(
              :"gpt-4o-audio-preview-2024-10-01",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-audio-preview-2024-12-17",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2025_06_03 =
            T.let(
              :"gpt-4o-audio-preview-2025-06-03",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_AUDIO_PREVIEW =
            T.let(
              :"gpt-4o-mini-audio-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-mini-audio-preview-2024-12-17",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_SEARCH_PREVIEW =
            T.let(
              :"gpt-4o-search-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_SEARCH_PREVIEW =
            T.let(
              :"gpt-4o-mini-search-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :"gpt-4o-search-preview-2025-03-11",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :"gpt-4o-mini-search-preview-2025-03-11",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          CHATGPT_4O_LATEST =
            T.let(
              :"chatgpt-4o-latest",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          CODEX_MINI_LATEST =
            T.let(
              :"codex-mini-latest",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI =
            T.let(
              :"gpt-4o-mini",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_2024_07_18 =
            T.let(
              :"gpt-4o-mini-2024-07-18",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_TURBO =
            T.let(
              :"gpt-4-turbo",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_TURBO_2024_04_09 =
            T.let(
              :"gpt-4-turbo-2024-04-09",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_0125_PREVIEW =
            T.let(
              :"gpt-4-0125-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_TURBO_PREVIEW =
            T.let(
              :"gpt-4-turbo-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1106_PREVIEW =
            T.let(
              :"gpt-4-1106-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_VISION_PREVIEW =
            T.let(
              :"gpt-4-vision-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4 =
            T.let(
              :"gpt-4",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_0314 =
            T.let(
              :"gpt-4-0314",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_0613 =
            T.let(
              :"gpt-4-0613",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_32K =
            T.let(
              :"gpt-4-32k",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_32K_0314 =
            T.let(
              :"gpt-4-32k-0314",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_32K_0613 =
            T.let(
              :"gpt-4-32k-0613",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO =
            T.let(
              :"gpt-3.5-turbo",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_16K =
            T.let(
              :"gpt-3.5-turbo-16k",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0301 =
            T.let(
              :"gpt-3.5-turbo-0301",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0613 =
            T.let(
              :"gpt-3.5-turbo-0613",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_1106 =
            T.let(
              :"gpt-3.5-turbo-1106",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0125 =
            T.let(
              :"gpt-3.5-turbo-0125",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_16K_0613 =
            T.let(
              :"gpt-3.5-turbo-16k-0613",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PRO =
            T.let(
              :"o1-pro",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PRO_2025_03_19 =
            T.let(
              :"o1-pro-2025-03-19",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_PRO =
            T.let(
              :"o3-pro",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_PRO_2025_06_10 =
            T.let(
              :"o3-pro-2025-06-10",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_DEEP_RESEARCH =
            T.let(
              :"o3-deep-research",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_DEEP_RESEARCH_2025_06_26 =
            T.let(
              :"o3-deep-research-2025-06-26",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI_DEEP_RESEARCH =
            T.let(
              :"o4-mini-deep-research",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI_DEEP_RESEARCH_2025_06_26 =
            T.let(
              :"o4-mini-deep-research-2025-06-26",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW =
            T.let(
              :"computer-use-preview",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW_2025_03_11 =
            T.let(
              :"computer-use-preview-2025-03-11",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_CODEX =
            T.let(
              :"gpt-5-codex",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_PRO =
            T.let(
              :"gpt-5-pro",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_PRO_2025_10_06 =
            T.let(
              :"gpt-5-pro-2025-10-06",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_CODEX_MAX =
            T.let(
              :"gpt-5.1-codex-max",
              OpenAI::Beta::ResponseCompactParams::Model::TaggedSymbol
            )
        end

        # Text, image, or file inputs to the model, used to generate a response
        module Input
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[OpenAI::Beta::BetaResponseInputItem::Variants]
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCompactParams::Input::Variants]
            )
          end
          def self.variants
          end

          BetaResponseInputItemArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                union: OpenAI::Beta::BetaResponseInputItem
              ],
              OpenAI::Internal::Type::Converter
            )
        end

        class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions,
                OpenAI::Internal::AnyHash
              )
            end

          # Controls whether OpenAI automatically creates an implicit cache breakpoint.
          # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
          # and writes up to the latest three explicit breakpoints in the request. With
          # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
          # latest four explicit breakpoints. If there are no explicit breakpoints, the
          # request does not use prompt caching.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::OrSymbol
              )
            )
          end
          attr_reader :mode

          sig do
            params(
              mode:
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::OrSymbol
            ).void
          end
          attr_writer :mode

          # The minimum lifetime applied to every implicit and explicit cache breakpoint
          # written by the request. Defaults to `30m`, which is currently the only supported
          # value. The backend may retain cache entries for longer.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl::OrSymbol
              )
            )
          end
          attr_reader :ttl

          sig do
            params(
              ttl:
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl::OrSymbol
            ).void
          end
          attr_writer :ttl

          # Options for prompt caching. Supported for `gpt-5.6` and later models. By
          # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
          # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
          # request can write up to four breakpoints. For cache matching, OpenAI considers
          # up to the latest 80 breakpoints in the conversation, without a content-block
          # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
          # `ttl` defaults to `30m`, which is currently the only supported value. See the
          # [prompt caching guide](https://platform.openai.com/docs/guides/prompt-caching)
          # for current details.
          sig do
            params(
              mode:
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::OrSymbol,
              ttl:
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Controls whether OpenAI automatically creates an implicit cache breakpoint.
            # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
            # and writes up to the latest three explicit breakpoints in the request. With
            # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
            # latest four explicit breakpoints. If there are no explicit breakpoints, the
            # request does not use prompt caching.
            mode: nil,
            # The minimum lifetime applied to every implicit and explicit cache breakpoint
            # written by the request. Defaults to `30m`, which is currently the only supported
            # value. The backend may retain cache entries for longer.
            ttl: nil
          )
          end

          sig do
            override.returns(
              {
                mode:
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::OrSymbol,
                ttl:
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Controls whether OpenAI automatically creates an implicit cache breakpoint.
          # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
          # and writes up to the latest three explicit breakpoints in the request. With
          # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
          # latest four explicit breakpoints. If there are no explicit breakpoints, the
          # request does not use prompt caching.
          module Mode
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IMPLICIT =
              T.let(
                :implicit,
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::TaggedSymbol
              )
            EXPLICIT =
              T.let(
                :explicit,
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Mode::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The minimum lifetime applied to every implicit and explicit cache breakpoint
          # written by the request. Defaults to `30m`, which is currently the only supported
          # value. The backend may retain cache entries for longer.
          module Ttl
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            TTL_30M =
              T.let(
                :"30m",
                OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ResponseCompactParams::PromptCacheOptions::Ttl::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # How long to retain a prompt cache entry created by this request.
        module PromptCacheRetention
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Beta::ResponseCompactParams::PromptCacheRetention
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_MEMORY =
            T.let(
              :in_memory,
              OpenAI::Beta::ResponseCompactParams::PromptCacheRetention::TaggedSymbol
            )
          PROMPT_CACHE_RETENTION_24H =
            T.let(
              :"24h",
              OpenAI::Beta::ResponseCompactParams::PromptCacheRetention::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::ResponseCompactParams::PromptCacheRetention::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The service tier to use for this request.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseCompactParams::ServiceTier)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Beta::ResponseCompactParams::ServiceTier::TaggedSymbol
            )
          DEFAULT =
            T.let(
              :default,
              OpenAI::Beta::ResponseCompactParams::ServiceTier::TaggedSymbol
            )
          FLEX =
            T.let(
              :flex,
              OpenAI::Beta::ResponseCompactParams::ServiceTier::TaggedSymbol
            )
          PRIORITY =
            T.let(
              :priority,
              OpenAI::Beta::ResponseCompactParams::ServiceTier::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::ResponseCompactParams::ServiceTier::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        module Beta
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::ResponseCompactParams::Beta)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          RESPONSES_MULTI_AGENT_V1 =
            T.let(
              :"responses_multi_agent=v1",
              OpenAI::Beta::ResponseCompactParams::Beta::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ResponseCompactParams::Beta::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
