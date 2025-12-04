# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCompactParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCompactParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Text, image, or file inputs to the model, used to generate a response
        sig do
          returns(
            T.nilable(OpenAI::Responses::ResponseCompactParams::Input::Variants)
          )
        end
        attr_accessor :input

        # A system (or developer) message inserted into the model's context. When used
        # along with `previous_response_id`, the instructions from a previous response
        # will not be carried over to the next response. This makes it simple to swap out
        # system (or developer) messages in new responses.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ResponseCompactParams::Model::OrSymbol,
                String
              )
            )
          )
        end
        attr_accessor :model

        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        # Cannot be used in conjunction with `conversation`.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_response_id

        sig do
          params(
            input:
              T.nilable(
                OpenAI::Responses::ResponseCompactParams::Input::Variants
              ),
            instructions: T.nilable(String),
            model:
              T.nilable(
                T.any(
                  OpenAI::Responses::ResponseCompactParams::Model::OrSymbol,
                  String
                )
              ),
            previous_response_id: T.nilable(String),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Text, image, or file inputs to the model, used to generate a response
          input: nil,
          # A system (or developer) message inserted into the model's context. When used
          # along with `previous_response_id`, the instructions from a previous response
          # will not be carried over to the next response. This makes it simple to swap out
          # system (or developer) messages in new responses.
          instructions: nil,
          # Model ID used to generate the response, like `gpt-5` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          model: nil,
          # The unique ID of the previous response to the model. Use this to create
          # multi-turn conversations. Learn more about
          # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
          # Cannot be used in conjunction with `conversation`.
          previous_response_id: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              input:
                T.nilable(
                  OpenAI::Responses::ResponseCompactParams::Input::Variants
                ),
              instructions: T.nilable(String),
              model:
                T.nilable(
                  T.any(
                    OpenAI::Responses::ResponseCompactParams::Model::OrSymbol,
                    String
                  )
                ),
              previous_response_id: T.nilable(String),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Text, image, or file inputs to the model, used to generate a response
        module Input
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[OpenAI::Responses::ResponseInputItem::Variants]
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCompactParams::Input::Variants
              ]
            )
          end
          def self.variants
          end

          ResponseInputItemArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                union: OpenAI::Responses::ResponseInputItem
              ],
              OpenAI::Internal::Type::Converter
            )
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
                OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol,
                String
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCompactParams::Model::Variants
              ]
            )
          end
          def self.variants
          end

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseCompactParams::Model)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          GPT_5_1 =
            T.let(
              :"gpt-5.1",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_2025_11_13 =
            T.let(
              :"gpt-5.1-2025-11-13",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_CODEX =
            T.let(
              :"gpt-5.1-codex",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_MINI =
            T.let(
              :"gpt-5.1-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_CHAT_LATEST =
            T.let(
              :"gpt-5.1-chat-latest",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5 =
            T.let(
              :"gpt-5",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_MINI =
            T.let(
              :"gpt-5-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_NANO =
            T.let(
              :"gpt-5-nano",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_2025_08_07 =
            T.let(
              :"gpt-5-2025-08-07",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_MINI_2025_08_07 =
            T.let(
              :"gpt-5-mini-2025-08-07",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_NANO_2025_08_07 =
            T.let(
              :"gpt-5-nano-2025-08-07",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_CHAT_LATEST =
            T.let(
              :"gpt-5-chat-latest",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1 =
            T.let(
              :"gpt-4.1",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_MINI =
            T.let(
              :"gpt-4.1-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_NANO =
            T.let(
              :"gpt-4.1-nano",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_2025_04_14 =
            T.let(
              :"gpt-4.1-2025-04-14",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_MINI_2025_04_14 =
            T.let(
              :"gpt-4.1-mini-2025-04-14",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1_NANO_2025_04_14 =
            T.let(
              :"gpt-4.1-nano-2025-04-14",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI =
            T.let(
              :"o4-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI_2025_04_16 =
            T.let(
              :"o4-mini-2025-04-16",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3 =
            T.let(
              :o3,
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_2025_04_16 =
            T.let(
              :"o3-2025-04-16",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_MINI =
            T.let(
              :"o3-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_MINI_2025_01_31 =
            T.let(
              :"o3-mini-2025-01-31",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1 =
            T.let(
              :o1,
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_2024_12_17 =
            T.let(
              :"o1-2024-12-17",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PREVIEW =
            T.let(
              :"o1-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PREVIEW_2024_09_12 =
            T.let(
              :"o1-preview-2024-09-12",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_MINI =
            T.let(
              :"o1-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_MINI_2024_09_12 =
            T.let(
              :"o1-mini-2024-09-12",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O =
            T.let(
              :"gpt-4o",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_2024_11_20 =
            T.let(
              :"gpt-4o-2024-11-20",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_2024_08_06 =
            T.let(
              :"gpt-4o-2024-08-06",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_2024_05_13 =
            T.let(
              :"gpt-4o-2024-05-13",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW =
            T.let(
              :"gpt-4o-audio-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2024_10_01 =
            T.let(
              :"gpt-4o-audio-preview-2024-10-01",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-audio-preview-2024-12-17",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_AUDIO_PREVIEW_2025_06_03 =
            T.let(
              :"gpt-4o-audio-preview-2025-06-03",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_AUDIO_PREVIEW =
            T.let(
              :"gpt-4o-mini-audio-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 =
            T.let(
              :"gpt-4o-mini-audio-preview-2024-12-17",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_SEARCH_PREVIEW =
            T.let(
              :"gpt-4o-search-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_SEARCH_PREVIEW =
            T.let(
              :"gpt-4o-mini-search-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :"gpt-4o-search-preview-2025-03-11",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 =
            T.let(
              :"gpt-4o-mini-search-preview-2025-03-11",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          CHATGPT_4O_LATEST =
            T.let(
              :"chatgpt-4o-latest",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          CODEX_MINI_LATEST =
            T.let(
              :"codex-mini-latest",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI =
            T.let(
              :"gpt-4o-mini",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4O_MINI_2024_07_18 =
            T.let(
              :"gpt-4o-mini-2024-07-18",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_TURBO =
            T.let(
              :"gpt-4-turbo",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_TURBO_2024_04_09 =
            T.let(
              :"gpt-4-turbo-2024-04-09",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_0125_PREVIEW =
            T.let(
              :"gpt-4-0125-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_TURBO_PREVIEW =
            T.let(
              :"gpt-4-turbo-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_1106_PREVIEW =
            T.let(
              :"gpt-4-1106-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_VISION_PREVIEW =
            T.let(
              :"gpt-4-vision-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4 =
            T.let(
              :"gpt-4",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_0314 =
            T.let(
              :"gpt-4-0314",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_0613 =
            T.let(
              :"gpt-4-0613",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_32K =
            T.let(
              :"gpt-4-32k",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_32K_0314 =
            T.let(
              :"gpt-4-32k-0314",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_4_32K_0613 =
            T.let(
              :"gpt-4-32k-0613",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO =
            T.let(
              :"gpt-3.5-turbo",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_16K =
            T.let(
              :"gpt-3.5-turbo-16k",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0301 =
            T.let(
              :"gpt-3.5-turbo-0301",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0613 =
            T.let(
              :"gpt-3.5-turbo-0613",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_1106 =
            T.let(
              :"gpt-3.5-turbo-1106",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_0125 =
            T.let(
              :"gpt-3.5-turbo-0125",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_3_5_TURBO_16K_0613 =
            T.let(
              :"gpt-3.5-turbo-16k-0613",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PRO =
            T.let(
              :"o1-pro",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O1_PRO_2025_03_19 =
            T.let(
              :"o1-pro-2025-03-19",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_PRO =
            T.let(
              :"o3-pro",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_PRO_2025_06_10 =
            T.let(
              :"o3-pro-2025-06-10",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_DEEP_RESEARCH =
            T.let(
              :"o3-deep-research",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O3_DEEP_RESEARCH_2025_06_26 =
            T.let(
              :"o3-deep-research-2025-06-26",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI_DEEP_RESEARCH =
            T.let(
              :"o4-mini-deep-research",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          O4_MINI_DEEP_RESEARCH_2025_06_26 =
            T.let(
              :"o4-mini-deep-research-2025-06-26",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW =
            T.let(
              :"computer-use-preview",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          COMPUTER_USE_PREVIEW_2025_03_11 =
            T.let(
              :"computer-use-preview-2025-03-11",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_CODEX =
            T.let(
              :"gpt-5-codex",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_PRO =
            T.let(
              :"gpt-5-pro",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_PRO_2025_10_06 =
            T.let(
              :"gpt-5-pro-2025-10-06",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
          GPT_5_1_CODEX_MAX =
            T.let(
              :"gpt-5.1-codex-max",
              OpenAI::Responses::ResponseCompactParams::Model::TaggedSymbol
            )
        end
      end
    end
  end
end
