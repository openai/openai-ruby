# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @see OpenAI::Resources::Chat::Completions#create
      #
      # @see OpenAI::Resources::Chat::Completions#stream_raw
      class ChatCompletion < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   A unique identifier for the chat completion.
        #
        #   @return [String]
        required :id, String

        # @!attribute choices
        #   A list of chat completion choices. Can be more than one if `n` is greater
        #   than 1.
        #
        #   @return [Array<OpenAI::Models::Chat::ChatCompletion::Choice>]
        required :choices, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletion::Choice] }

        # @!attribute created
        #   The Unix timestamp (in seconds) of when the chat completion was created.
        #
        #   @return [Integer]
        required :created, Integer

        # @!attribute model
        #   The model used for the chat completion.
        #
        #   @return [String]
        required :model, String

        # @!attribute object
        #   The object type, which is always `chat.completion`.
        #
        #   @return [Symbol, :"chat.completion"]
        required :object, const: :"chat.completion"

        # @!attribute moderation
        #   Moderation results for the request input and generated output, if moderated
        #   completions were requested.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletion::Moderation, nil]
        optional :moderation, -> { OpenAI::Chat::ChatCompletion::Moderation }, nil?: true

        # @!attribute service_tier
        #   Specifies the processing type used for serving the request.
        #
        #   - If set to 'auto', then the request will be processed with the service tier
        #     configured in the Project settings. Unless otherwise configured, the Project
        #     will use 'default'.
        #   - If set to 'default', then the request will be processed with the standard
        #     pricing and performance for the selected model.
        #   - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #     '[priority](https://openai.com/api-priority-processing/)', then the request
        #     will be processed with the corresponding service tier.
        #   - When not set, the default behavior is 'auto'.
        #
        #   When the `service_tier` parameter is set, the response body will include the
        #   `service_tier` value based on the processing mode actually used to serve the
        #   request. This response value may be different from the value set in the
        #   parameter.
        #
        #   @return [Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier, nil]
        optional :service_tier, enum: -> { OpenAI::Chat::ChatCompletion::ServiceTier }, nil?: true

        # @!attribute system_fingerprint
        #   @deprecated
        #
        #   This fingerprint represents the backend configuration that the model runs with.
        #
        #   Can be used in conjunction with the `seed` request parameter to understand when
        #   backend changes have been made that might impact determinism.
        #
        #   @return [String, nil]
        optional :system_fingerprint, String

        # @!attribute usage
        #   Usage statistics for the completion request.
        #
        #   @return [OpenAI::Models::CompletionUsage, nil]
        optional :usage, -> { OpenAI::CompletionUsage }

        # @!method initialize(id:, choices:, created:, model:, moderation: nil, service_tier: nil, system_fingerprint: nil, usage: nil, object: :"chat.completion")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletion} for more details.
        #
        #   Represents a chat completion response returned by model, based on the provided
        #   input.
        #
        #   @param id [String] A unique identifier for the chat completion.
        #
        #   @param choices [Array<OpenAI::Models::Chat::ChatCompletion::Choice>] A list of chat completion choices. Can be more than one if `n` is greater than 1
        #
        #   @param created [Integer] The Unix timestamp (in seconds) of when the chat completion was created.
        #
        #   @param model [String] The model used for the chat completion.
        #
        #   @param moderation [OpenAI::Models::Chat::ChatCompletion::Moderation, nil] Moderation results for the request input and generated output, if moderated
        #
        #   @param service_tier [Symbol, OpenAI::Models::Chat::ChatCompletion::ServiceTier, nil] Specifies the processing type used for serving the request.
        #
        #   @param system_fingerprint [String] This fingerprint represents the backend configuration that the model runs with.
        #
        #   @param usage [OpenAI::Models::CompletionUsage] Usage statistics for the completion request.
        #
        #   @param object [Symbol, :"chat.completion"] The object type, which is always `chat.completion`.

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute finish_reason
          #   The reason the model stopped generating tokens. This will be `stop` if the model
          #   hit a natural stop point or a provided stop sequence, `length` if the maximum
          #   number of tokens specified in the request was reached, `content_filter` if
          #   content was omitted due to a flag from our content filters, `tool_calls` if the
          #   model called a tool, or `function_call` (deprecated) if the model called a
          #   function. Read the [Model Spec](https://model-spec.openai.com/2025-12-18.html)
          #   for more.
          #
          #   @return [Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason]
          required :finish_reason, enum: -> { OpenAI::Chat::ChatCompletion::Choice::FinishReason }

          # @!attribute index
          #   The index of the choice in the list of choices.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute logprobs
          #   Log probability information for the choice.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, nil]
          required :logprobs, -> { OpenAI::Chat::ChatCompletion::Choice::Logprobs }, nil?: true

          # @!attribute message
          #   A chat completion message generated by the model.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionMessage]
          required :message, -> { OpenAI::Chat::ChatCompletionMessage }

          # @!method initialize(finish_reason:, index:, logprobs:, message:)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Chat::ChatCompletion::Choice} for more details.
          #
          #   @param finish_reason [Symbol, OpenAI::Models::Chat::ChatCompletion::Choice::FinishReason] The reason the model stopped generating tokens. This will be `stop` if the model
          #
          #   @param index [Integer] The index of the choice in the list of choices.
          #
          #   @param logprobs [OpenAI::Models::Chat::ChatCompletion::Choice::Logprobs, nil] Log probability information for the choice.
          #
          #   @param message [OpenAI::Models::Chat::ChatCompletionMessage] A chat completion message generated by the model.

          # The reason the model stopped generating tokens. This will be `stop` if the model
          # hit a natural stop point or a provided stop sequence, `length` if the maximum
          # number of tokens specified in the request was reached, `content_filter` if
          # content was omitted due to a flag from our content filters, `tool_calls` if the
          # model called a tool, or `function_call` (deprecated) if the model called a
          # function. Read the [Model Spec](https://model-spec.openai.com/2025-12-18.html)
          # for more.
          #
          # @see OpenAI::Models::Chat::ChatCompletion::Choice#finish_reason
          module FinishReason
            extend OpenAI::Internal::Type::Enum

            STOP = :stop
            LENGTH = :length
            TOOL_CALLS = :tool_calls
            CONTENT_FILTER = :content_filter
            FUNCTION_CALL = :function_call

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Chat::ChatCompletion::Choice#logprobs
          class Logprobs < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A list of message content tokens with log probability information.
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            required :content,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] },
                     nil?: true

            # @!attribute refusal
            #   A list of message refusal tokens with log probability information.
            #
            #   @return [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil]
            required :refusal,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletionTokenLogprob] },
                     nil?: true

            # @!method initialize(content:, refusal:)
            #   Log probability information for the choice.
            #
            #   @param content [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil] A list of message content tokens with log probability information.
            #
            #   @param refusal [Array<OpenAI::Models::Chat::ChatCompletionTokenLogprob>, nil] A list of message refusal tokens with log probability information.
          end
        end

        # @see OpenAI::Models::Chat::ChatCompletion#moderation
        class Moderation < OpenAI::Internal::Type::BaseModel
          # @!attribute input
          #   Moderation for the request input.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults, OpenAI::Models::Chat::ChatCompletion::Moderation::Input::Error]
          required :input, union: -> { OpenAI::Chat::ChatCompletion::Moderation::Input }

          # @!attribute output
          #   Moderation for the generated output.
          #
          #   @return [OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults, OpenAI::Models::Chat::ChatCompletion::Moderation::Output::Error]
          required :output, union: -> { OpenAI::Chat::ChatCompletion::Moderation::Output }

          # @!method initialize(input:, output:)
          #   Moderation results for the request input and generated output, if moderated
          #   completions were requested.
          #
          #   @param input [OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults, OpenAI::Models::Chat::ChatCompletion::Moderation::Input::Error] Moderation for the request input.
          #
          #   @param output [OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults, OpenAI::Models::Chat::ChatCompletion::Moderation::Output::Error] Moderation for the generated output.

          # Moderation for the request input.
          #
          # @see OpenAI::Models::Chat::ChatCompletion::Moderation#input
          module Input
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Successful moderation results for the request input or generated output.
            variant :moderation_results, -> { OpenAI::Chat::ChatCompletion::Moderation::Input::ModerationResults }

            # An error produced while attempting moderation.
            variant :error, -> { OpenAI::Chat::ChatCompletion::Moderation::Input::Error }

            class ModerationResults < OpenAI::Internal::Type::BaseModel
              # @!attribute model
              #   The moderation model used to generate the results.
              #
              #   @return [String]
              required :model, String

              # @!attribute results
              #   A list of moderation results.
              #
              #   @return [Array<OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result>]
              required :results,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result] }

              # @!attribute type
              #   The object type, which is always `moderation_results`.
              #
              #   @return [Symbol, :moderation_results]
              required :type, const: :moderation_results

              # @!method initialize(model:, results:, type: :moderation_results)
              #   Successful moderation results for the request input or generated output.
              #
              #   @param model [String] The moderation model used to generate the results.
              #
              #   @param results [Array<OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result>] A list of moderation results.
              #
              #   @param type [Symbol, :moderation_results] The object type, which is always `moderation_results`.

              class Result < OpenAI::Internal::Type::BaseModel
                # @!attribute categories
                #   A dictionary of moderation categories to booleans, True if the input is flagged
                #   under this category.
                #
                #   @return [Hash{Symbol=>Boolean}]
                required :categories, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Boolean]

                # @!attribute category_applied_input_types
                #   Which modalities of input are reflected by the score for each category.
                #
                #   @return [Hash{Symbol=>Array<Symbol, OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result::CategoryAppliedInputType>}]
                required :category_applied_input_types,
                         -> do
                           OpenAI::Internal::Type::HashOf[
                             OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result::CategoryAppliedInputType]
                           ]
                         end

                # @!attribute category_scores
                #   A dictionary of moderation categories to scores.
                #
                #   @return [Hash{Symbol=>Float}]
                required :category_scores, OpenAI::Internal::Type::HashOf[Float]

                # @!attribute flagged
                #   A boolean indicating whether the content was flagged by any category.
                #
                #   @return [Boolean]
                required :flagged, OpenAI::Internal::Type::Boolean

                # @!attribute model
                #   The moderation model that produced this result.
                #
                #   @return [String]
                required :model, String

                # @!attribute type
                #   The object type, which was always `moderation_result` for successful moderation
                #   results.
                #
                #   @return [Symbol, :moderation_result]
                required :type, const: :moderation_result

                # @!method initialize(categories:, category_applied_input_types:, category_scores:, flagged:, model:, type: :moderation_result)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result}
                #   for more details.
                #
                #   A moderation result produced for the response input or output.
                #
                #   @param categories [Hash{Symbol=>Boolean}] A dictionary of moderation categories to booleans, True if the input is flagged
                #
                #   @param category_applied_input_types [Hash{Symbol=>Array<Symbol, OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults::Result::CategoryAppliedInputType>}] Which modalities of input are reflected by the score for each category.
                #
                #   @param category_scores [Hash{Symbol=>Float}] A dictionary of moderation categories to scores.
                #
                #   @param flagged [Boolean] A boolean indicating whether the content was flagged by any category.
                #
                #   @param model [String] The moderation model that produced this result.
                #
                #   @param type [Symbol, :moderation_result] The object type, which was always `moderation_result` for successful moderation

                module CategoryAppliedInputType
                  extend OpenAI::Internal::Type::Enum

                  TEXT = :text
                  IMAGE = :image

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end
            end

            class Error < OpenAI::Internal::Type::BaseModel
              # @!attribute code
              #   The error code.
              #
              #   @return [String]
              required :code, String

              # @!attribute message
              #   The error message.
              #
              #   @return [String]
              required :message, String

              # @!attribute type
              #   The object type, which is always `error`.
              #
              #   @return [Symbol, :error]
              required :type, const: :error

              # @!method initialize(code:, message:, type: :error)
              #   An error produced while attempting moderation.
              #
              #   @param code [String] The error code.
              #
              #   @param message [String] The error message.
              #
              #   @param type [Symbol, :error] The object type, which is always `error`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Chat::ChatCompletion::Moderation::Input::ModerationResults, OpenAI::Models::Chat::ChatCompletion::Moderation::Input::Error)]
          end

          # Moderation for the generated output.
          #
          # @see OpenAI::Models::Chat::ChatCompletion::Moderation#output
          module Output
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Successful moderation results for the request input or generated output.
            variant :moderation_results, -> { OpenAI::Chat::ChatCompletion::Moderation::Output::ModerationResults }

            # An error produced while attempting moderation.
            variant :error, -> { OpenAI::Chat::ChatCompletion::Moderation::Output::Error }

            class ModerationResults < OpenAI::Internal::Type::BaseModel
              # @!attribute model
              #   The moderation model used to generate the results.
              #
              #   @return [String]
              required :model, String

              # @!attribute results
              #   A list of moderation results.
              #
              #   @return [Array<OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result>]
              required :results,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result] }

              # @!attribute type
              #   The object type, which is always `moderation_results`.
              #
              #   @return [Symbol, :moderation_results]
              required :type, const: :moderation_results

              # @!method initialize(model:, results:, type: :moderation_results)
              #   Successful moderation results for the request input or generated output.
              #
              #   @param model [String] The moderation model used to generate the results.
              #
              #   @param results [Array<OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result>] A list of moderation results.
              #
              #   @param type [Symbol, :moderation_results] The object type, which is always `moderation_results`.

              class Result < OpenAI::Internal::Type::BaseModel
                # @!attribute categories
                #   A dictionary of moderation categories to booleans, True if the input is flagged
                #   under this category.
                #
                #   @return [Hash{Symbol=>Boolean}]
                required :categories, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Boolean]

                # @!attribute category_applied_input_types
                #   Which modalities of input are reflected by the score for each category.
                #
                #   @return [Hash{Symbol=>Array<Symbol, OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result::CategoryAppliedInputType>}]
                required :category_applied_input_types,
                         -> do
                           OpenAI::Internal::Type::HashOf[
                             OpenAI::Internal::Type::ArrayOf[
                               enum: OpenAI::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result::CategoryAppliedInputType
                             ]
                           ]
                         end

                # @!attribute category_scores
                #   A dictionary of moderation categories to scores.
                #
                #   @return [Hash{Symbol=>Float}]
                required :category_scores, OpenAI::Internal::Type::HashOf[Float]

                # @!attribute flagged
                #   A boolean indicating whether the content was flagged by any category.
                #
                #   @return [Boolean]
                required :flagged, OpenAI::Internal::Type::Boolean

                # @!attribute model
                #   The moderation model that produced this result.
                #
                #   @return [String]
                required :model, String

                # @!attribute type
                #   The object type, which was always `moderation_result` for successful moderation
                #   results.
                #
                #   @return [Symbol, :moderation_result]
                required :type, const: :moderation_result

                # @!method initialize(categories:, category_applied_input_types:, category_scores:, flagged:, model:, type: :moderation_result)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result}
                #   for more details.
                #
                #   A moderation result produced for the response input or output.
                #
                #   @param categories [Hash{Symbol=>Boolean}] A dictionary of moderation categories to booleans, True if the input is flagged
                #
                #   @param category_applied_input_types [Hash{Symbol=>Array<Symbol, OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults::Result::CategoryAppliedInputType>}] Which modalities of input are reflected by the score for each category.
                #
                #   @param category_scores [Hash{Symbol=>Float}] A dictionary of moderation categories to scores.
                #
                #   @param flagged [Boolean] A boolean indicating whether the content was flagged by any category.
                #
                #   @param model [String] The moderation model that produced this result.
                #
                #   @param type [Symbol, :moderation_result] The object type, which was always `moderation_result` for successful moderation

                module CategoryAppliedInputType
                  extend OpenAI::Internal::Type::Enum

                  TEXT = :text
                  IMAGE = :image

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end
            end

            class Error < OpenAI::Internal::Type::BaseModel
              # @!attribute code
              #   The error code.
              #
              #   @return [String]
              required :code, String

              # @!attribute message
              #   The error message.
              #
              #   @return [String]
              required :message, String

              # @!attribute type
              #   The object type, which is always `error`.
              #
              #   @return [Symbol, :error]
              required :type, const: :error

              # @!method initialize(code:, message:, type: :error)
              #   An error produced while attempting moderation.
              #
              #   @param code [String] The error code.
              #
              #   @param message [String] The error message.
              #
              #   @param type [Symbol, :error] The object type, which is always `error`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Chat::ChatCompletion::Moderation::Output::ModerationResults, OpenAI::Models::Chat::ChatCompletion::Moderation::Output::Error)]
          end
        end

        # Specifies the processing type used for serving the request.
        #
        # - If set to 'auto', then the request will be processed with the service tier
        #   configured in the Project settings. Unless otherwise configured, the Project
        #   will use 'default'.
        # - If set to 'default', then the request will be processed with the standard
        #   pricing and performance for the selected model.
        # - If set to '[flex](https://platform.openai.com/docs/guides/flex-processing)' or
        #   '[priority](https://openai.com/api-priority-processing/)', then the request
        #   will be processed with the corresponding service tier.
        # - When not set, the default behavior is 'auto'.
        #
        # When the `service_tier` parameter is set, the response body will include the
        # `service_tier` value based on the processing mode actually used to serve the
        # request. This response value may be different from the value set in the
        # parameter.
        #
        # @see OpenAI::Models::Chat::ChatCompletion#service_tier
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          AUTO = :auto
          DEFAULT = :default
          FLEX = :flex
          SCALE = :scale
          PRIORITY = :priority

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    ChatCompletion = Chat::ChatCompletion
  end
end
