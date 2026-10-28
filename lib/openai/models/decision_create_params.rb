# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Decisions#create
    class DecisionCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute input
      #   The input to evaluate for every question. Provide a text string or an ordered
      #   array of messages, function calls and outputs, or custom tool calls and outputs.
      #   Each tool output must identify a matching call by call ID.
      #
      #   @return [String, Array<OpenAI::Models::decision_input_message, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput>]
      required :input, union: -> { OpenAI::DecisionCreateParams::Input }

      # @!attribute model
      #   The model to use. Only `gpt-6-luna` is supported.
      #
      #   @return [String]
      required :model, String

      # @!attribute questions
      #   Ask 1–400 questions about the input. Each question can be a predicate, choice,
      #   or score. Answers come back in the same order.
      #
      #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      required :questions, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionCreateParams::Question] }

      # @!attribute prompt_cache_key
      #   Partition prompt cache reuse by caller-provided key.
      #
      #   @return [String, nil]
      optional :prompt_cache_key, String, nil?: true

      # @!attribute prompt_cache_options
      #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #   request can write up to four breakpoints. For cache matching, OpenAI considers
      #   up to the latest 80 breakpoints in the conversation, without a content-block
      #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #   `ttl` defaults to `30m`, which is currently the only supported value. See the
      #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #   for current details.
      #
      #   @return [OpenAI::Models::DecisionCreateParams::PromptCacheOptions, nil]
      optional :prompt_cache_options, -> { OpenAI::DecisionCreateParams::PromptCacheOptions }, nil?: true

      # @!attribute safety_identifier
      #   Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #   Responses' limit; this is never the authenticated user identity.
      #
      #   @return [String, nil]
      optional :safety_identifier, String, nil?: true

      # @!method initialize(input:, model:, questions:, prompt_cache_key: nil, prompt_cache_options: nil, safety_identifier: nil, request_options: {})
      #   @param input [String, Array<OpenAI::Models::decision_input_message, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput>]
      #     The input to evaluate for every question. Provide a text string or an ordered
      #     array of messages, function calls and outputs, or custom tool calls and outputs.
      #     Each tool output must identify a matching call by call ID.
      #
      #   @param model [String]
      #     The model to use. Only `gpt-6-luna` is supported.
      #
      #   @param questions [Array<OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score>]
      #     Ask 1–400 questions about the input. Each question can be a predicate, choice,
      #     or score. Answers come back in the same order.
      #
      #   @param prompt_cache_key [String, nil]
      #     Partition prompt cache reuse by caller-provided key.
      #
      #   @param prompt_cache_options [OpenAI::Models::DecisionCreateParams::PromptCacheOptions, nil]
      #     Options for prompt caching. Supported for `gpt-5.6` and later models. By
      #     default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      #     explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      #     request can write up to four breakpoints. For cache matching, OpenAI considers
      #     up to the latest 80 breakpoints in the conversation, without a content-block
      #     lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      #     `ttl` defaults to `30m`, which is currently the only supported value. See the
      #     [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      #     for current details.
      #
      #   @param safety_identifier [String, nil]
      #     Opaque caller-provided end-user identifier, scoped by the verified org. Match
      #     Responses' limit; this is never the authenticated user identity.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # The input to evaluate for every question. Provide a text string or an ordered
      # array of messages, function calls and outputs, or custom tool calls and outputs.
      # Each tool output must identify a matching call by call ID.
      module Input
        extend OpenAI::Internal::Type::Union

        variant String

        variant -> { OpenAI::Models::DecisionCreateParams::Input::UnionMember1Array }

        # A user message containing input text, images, or JSON.
        module UnionMember1
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A user message containing input text, images, or JSON.
          variant :message, -> { OpenAI::DecisionInputMessage }

          # A developer message containing input text.
          variant :message, -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage }

          # A system message containing input text.
          variant :message, -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage }

          # An assistant message containing output text or refusals.
          variant :message, -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage }

          variant :function_call, -> { OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall }

          variant(
            :function_call_output,
            -> { OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput }
          )

          variant :custom_tool_call, -> { OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall }

          variant(
            :custom_tool_call_output,
            -> { OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput }
          )

          class DecisionInputUserMessage < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A text string or an ordered list of text, image, and JSON parts.
            #
            #   @return [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON>]
            required(
              :content,
              union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Content }
            )

            # @!attribute role
            #
            #   @return [Symbol, :user]
            required :role, const: :user

            # @!attribute type
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type, nil]
            optional(
              :type,
              enum: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type }
            )

            # @!method initialize(content:, type: nil, role: :user)
            #   A user message containing input text, images, or JSON.
            #
            #   @param content [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON>]
            #     A text string or an ordered list of text, image, and JSON parts.
            #
            #   @param type [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type]
            #
            #   @param role [Symbol, :user]

            # A text string or an ordered list of text, image, and JSON parts.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage#content
            module Content
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Content::DecisionInputPartArray
                }
              )

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON>)]

              # @type [OpenAI::Internal::Type::Converter]
              DecisionInputPartArray = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::DecisionInputPart }]
            end

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage#type
            module Type
              extend OpenAI::Internal::Type::Enum

              MESSAGE = :message

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class DecisionInputDeveloperMessage < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A text string or an ordered list of input text parts.
            #
            #   @return [String, Array<OpenAI::Models::DecisionInputText>]
            required(
              :content,
              union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Content }
            )

            # @!attribute role
            #
            #   @return [Symbol, :developer]
            required :role, const: :developer

            # @!attribute type
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type, nil]
            optional(
              :type,
              enum: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type }
            )

            # @!method initialize(content:, type: nil, role: :developer)
            #   A developer message containing input text.
            #
            #   @param content [String, Array<OpenAI::Models::DecisionInputText>]
            #     A text string or an ordered list of input text parts.
            #
            #   @param type [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type]
            #
            #   @param role [Symbol, :developer]

            # A text string or an ordered list of input text parts.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage#content
            module Content
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Content::DecisionInputTextArray
                }
              )

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionInputText>)]

              # @type [OpenAI::Internal::Type::Converter]
              DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputText }]
            end

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage#type
            module Type
              extend OpenAI::Internal::Type::Enum

              MESSAGE = :message

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class DecisionInputSystemMessage < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A text string or an ordered list of input text parts.
            #
            #   @return [String, Array<OpenAI::Models::DecisionInputText>]
            required(
              :content,
              union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Content }
            )

            # @!attribute role
            #
            #   @return [Symbol, :system]
            required :role, const: :system

            # @!attribute type
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type, nil]
            optional(
              :type,
              enum: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type }
            )

            # @!method initialize(content:, type: nil, role: :system)
            #   A system message containing input text.
            #
            #   @param content [String, Array<OpenAI::Models::DecisionInputText>]
            #     A text string or an ordered list of input text parts.
            #
            #   @param type [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type]
            #
            #   @param role [Symbol, :system]

            # A text string or an ordered list of input text parts.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage#content
            module Content
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Content::DecisionInputTextArray
                }
              )

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionInputText>)]

              # @type [OpenAI::Internal::Type::Converter]
              DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputText }]
            end

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage#type
            module Type
              extend OpenAI::Internal::Type::Enum

              MESSAGE = :message

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class DecisionInputAssistantMessage < OpenAI::Internal::Type::BaseModel
            # @!attribute content
            #   A text string or an ordered list of output text and refusal parts.
            #
            #   @return [String, Array<OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal>]
            required(
              :content,
              union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content }
            )

            # @!attribute role
            #
            #   @return [Symbol, :assistant]
            required :role, const: :assistant

            # @!attribute phase
            #   The phase of an assistant message.
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase, nil]
            optional(
              :phase,
              enum: -> {
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase
              },
              nil?: true
            )

            # @!attribute type
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type, nil]
            optional(
              :type,
              enum: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type }
            )

            # @!method initialize(content:, phase: nil, type: nil, role: :assistant)
            #   An assistant message containing output text or refusals.
            #
            #   @param content [String, Array<OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal>]
            #     A text string or an ordered list of output text and refusal parts.
            #
            #   @param phase [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase, nil]
            #     The phase of an assistant message.
            #
            #   @param type [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type]
            #
            #   @param role [Symbol, :assistant]

            # A text string or an ordered list of output text and refusal parts.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage#content
            module Content
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::PartsArray
                }
              )

              module Part
                extend OpenAI::Internal::Type::Union

                discriminator :type

                variant(
                  :output_text,
                  -> {
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText
                  }
                )

                variant(
                  :refusal,
                  -> {
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal
                  }
                )

                class OutputText < OpenAI::Internal::Type::BaseModel
                  # @!attribute text
                  #
                  #   @return [String]
                  required :text, String

                  # @!attribute type
                  #
                  #   @return [Symbol, :output_text]
                  required :type, const: :output_text

                  # @!method initialize(text:, type: :output_text)
                  #   @param text [String]
                  #   @param type [Symbol, :output_text]
                end

                class Refusal < OpenAI::Internal::Type::BaseModel
                  # @!attribute refusal
                  #
                  #   @return [String]
                  required :refusal, String

                  # @!attribute type
                  #
                  #   @return [Symbol, :refusal]
                  required :type, const: :refusal

                  # @!method initialize(refusal:, type: :refusal)
                  #   @param refusal [String]
                  #   @param type [Symbol, :refusal]
                end

                # @!method self.variants
                #   @return [Array(OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal)]
              end

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal>)]

              # @type [OpenAI::Internal::Type::Converter]
              PartsArray = OpenAI::Internal::Type::ArrayOf[
                union: -> {
                  OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part
                }
              ]
            end

            # The phase of an assistant message.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage#phase
            module Phase
              extend OpenAI::Internal::Type::Enum

              COMMENTARY = :commentary
              FINAL_ANSWER = :final_answer

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage#type
            module Type
              extend OpenAI::Internal::Type::Enum

              MESSAGE = :message

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class FunctionCall < OpenAI::Internal::Type::BaseModel
            # @!attribute arguments
            #
            #   @return [String]
            required :arguments, String

            # @!attribute call_id
            #
            #   @return [String]
            required :call_id, String

            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute type
            #
            #   @return [Symbol, :function_call]
            required :type, const: :function_call

            # @!attribute id
            #
            #   @return [String, nil]
            optional :id, String, nil?: true

            # @!attribute namespace
            #
            #   @return [String, nil]
            optional :namespace, String, nil?: true

            # @!attribute status
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status, nil]
            optional(
              :status,
              enum: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status },
              nil?: true
            )

            # @!method initialize(arguments:, call_id:, name:, id: nil, namespace: nil, status: nil, type: :function_call)
            #   @param arguments [String]
            #   @param call_id [String]
            #   @param name [String]
            #   @param id [String, nil]
            #   @param namespace [String, nil]
            #   @param status [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status, nil]
            #   @param type [Symbol, :function_call]

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall#status
            module Status
              extend OpenAI::Internal::Type::Enum

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
            # @!attribute call_id
            #
            #   @return [String]
            required :call_id, String

            # @!attribute output
            #   Text evidence or an ordered list of text and image parts.
            #
            #   @return [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>]
            required(
              :output,
              union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output }
            )

            # @!attribute type
            #
            #   @return [Symbol, :function_call_output]
            required :type, const: :function_call_output

            # @!attribute id
            #
            #   @return [String, nil]
            optional :id, String, nil?: true

            # @!attribute status
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status, nil]
            optional(
              :status,
              enum: -> {
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status
              },
              nil?: true
            )

            # @!method initialize(call_id:, output:, id: nil, status: nil, type: :function_call_output)
            #   @param call_id [String]
            #
            #   @param output [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>]
            #     Text evidence or an ordered list of text and image parts.
            #
            #   @param id [String, nil]
            #
            #   @param status [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status, nil]
            #
            #   @param type [Symbol, :function_call_output]

            # Text evidence or an ordered list of text and image parts.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput#output
            module Output
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::PartsArray
                }
              )

              # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
              # File IDs are not supported.
              module Part
                extend OpenAI::Internal::Type::Union

                discriminator :type

                variant :input_text, -> { OpenAI::DecisionInputText }

                # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL. File IDs are not supported.
                variant :input_image, -> { OpenAI::DecisionInputImage }

                # @!method self.variants
                #   @return [Array(OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage)]
              end

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>)]

              # @type [OpenAI::Internal::Type::Converter]
              PartsArray = OpenAI::Internal::Type::ArrayOf[
                union: -> {
                  OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Part
                }
              ]
            end

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput#status
            module Status
              extend OpenAI::Internal::Type::Enum

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class CustomToolCall < OpenAI::Internal::Type::BaseModel
            # @!attribute call_id
            #
            #   @return [String]
            required :call_id, String

            # @!attribute input
            #
            #   @return [String]
            required :input, String

            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute type
            #
            #   @return [Symbol, :custom_tool_call]
            required :type, const: :custom_tool_call

            # @!attribute id
            #
            #   @return [String, nil]
            optional :id, String, nil?: true

            # @!attribute namespace
            #
            #   @return [String, nil]
            optional :namespace, String, nil?: true

            # @!attribute status
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status, nil]
            optional(
              :status,
              enum: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status },
              nil?: true
            )

            # @!method initialize(call_id:, input:, name:, id: nil, namespace: nil, status: nil, type: :custom_tool_call)
            #   @param call_id [String]
            #   @param input [String]
            #   @param name [String]
            #   @param id [String, nil]
            #   @param namespace [String, nil]
            #   @param status [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status, nil]
            #   @param type [Symbol, :custom_tool_call]

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall#status
            module Status
              extend OpenAI::Internal::Type::Enum

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class CustomToolCallOutput < OpenAI::Internal::Type::BaseModel
            # @!attribute call_id
            #
            #   @return [String]
            required :call_id, String

            # @!attribute output
            #   Text evidence or an ordered list of text and image parts.
            #
            #   @return [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>]
            required(
              :output,
              union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output }
            )

            # @!attribute type
            #
            #   @return [Symbol, :custom_tool_call_output]
            required :type, const: :custom_tool_call_output

            # @!attribute id
            #
            #   @return [String, nil]
            optional :id, String, nil?: true

            # @!attribute status
            #
            #   @return [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status, nil]
            optional(
              :status,
              enum: -> {
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status
              },
              nil?: true
            )

            # @!method initialize(call_id:, output:, id: nil, status: nil, type: :custom_tool_call_output)
            #   @param call_id [String]
            #
            #   @param output [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>]
            #     Text evidence or an ordered list of text and image parts.
            #
            #   @param id [String, nil]
            #
            #   @param status [Symbol, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status, nil]
            #
            #   @param type [Symbol, :custom_tool_call_output]

            # Text evidence or an ordered list of text and image parts.
            #
            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput#output
            module Output
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                -> {
                  OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::PartsArray
                }
              )

              # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
              # File IDs are not supported.
              module Part
                extend OpenAI::Internal::Type::Union

                discriminator :type

                variant :input_text, -> { OpenAI::DecisionInputText }

                # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL. File IDs are not supported.
                variant :input_image, -> { OpenAI::DecisionInputImage }

                # @!method self.variants
                #   @return [Array(OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage)]
              end

              # @!method self.variants
              #   @return [Array(String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage>)]

              # @type [OpenAI::Internal::Type::Converter]
              PartsArray = OpenAI::Internal::Type::ArrayOf[
                union: -> {
                  OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Part
                }
              ]
            end

            # @see OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput#status
            module Status
              extend OpenAI::Internal::Type::Enum

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput)]
        end

        # @!method self.variants
        #   @return [Array(String, Array<OpenAI::Models::decision_input_message, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCall, OpenAI::Models::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput>)]

        # @type [OpenAI::Internal::Type::Converter]
        UnionMember1Array = OpenAI::Internal::Type::ArrayOf[
          union: -> { OpenAI::DecisionCreateParams::Input::UnionMember1 }
        ]
      end

      # A question about the request's input, with an optional correlation name.
      module Question
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Estimate how likely it is that a statement about the input is true.
        variant :predicate, -> { OpenAI::DecisionCreateParams::Question::Predicate }

        # Choose from the supplied options based on the input.
        variant :choice, -> { OpenAI::DecisionCreateParams::Question::Choice }

        # Rate the input against the supplied ordered levels.
        variant :score, -> { OpenAI::DecisionCreateParams::Question::Score }

        class Predicate < OpenAI::Internal::Type::BaseModel
          # @!attribute instructions
          #
          #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          required :instructions, union: -> { OpenAI::DecisionCreateParams::Question::Predicate::Instructions }

          # @!attribute type
          #   The type of the object. Always `predicate`.
          #
          #   @return [Symbol, :predicate]
          required :type, const: :predicate

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(instructions:, name: nil, type: :predicate)
          #   Estimate how likely it is that a statement about the input is true.
          #
          #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          #
          #   @param name [String]
          #
          #   @param type [Symbol, :predicate]
          #     The type of the object. Always `predicate`.

          # @see OpenAI::Models::DecisionCreateParams::Question::Predicate#instructions
          module Instructions
            extend OpenAI::Internal::Type::Union

            variant String

            variant(
              -> {
                OpenAI::Models::DecisionCreateParams::Question::Predicate::Instructions::DecisionQuestionInputPartArray
              }
            )

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

            # @type [OpenAI::Internal::Type::Converter]
            DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
              union: -> { OpenAI::DecisionQuestionInputPart }
            ]
          end
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          # @!attribute choices
          #   Provide between 2 and 255 choices. Each choice must be unique.
          #
          #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Choice::Choice>]
          required(
            :choices,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionCreateParams::Question::Choice::Choice] }
          )

          # @!attribute instructions
          #
          #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          required :instructions, union: -> { OpenAI::DecisionCreateParams::Question::Choice::Instructions }

          # @!attribute type
          #   The type of the object. Always `choice`.
          #
          #   @return [Symbol, :choice]
          required :type, const: :choice

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(choices:, instructions:, name: nil, type: :choice)
          #   Choose from the supplied options based on the input.
          #
          #   @param choices [Array<OpenAI::Models::DecisionCreateParams::Question::Choice::Choice>]
          #     Provide between 2 and 255 choices. Each choice must be unique.
          #
          #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          #
          #   @param name [String]
          #
          #   @param type [Symbol, :choice]
          #     The type of the object. Always `choice`.
          class Choice < OpenAI::Internal::Type::BaseModel
            # @!attribute value
            #   Choice values are typed: a string and a boolean with the same text are distinct.
            #
            #   @return [String, Boolean]
            required :value, union: -> { OpenAI::DecisionCreateParams::Question::Choice::Choice::Value }

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String

            # @!method initialize(value:, description: nil)
            #   @param value [String, Boolean]
            #     Choice values are typed: a string and a boolean with the same text are distinct.
            #
            #   @param description [String]

            # Choice values are typed: a string and a boolean with the same text are distinct.
            #
            # @see OpenAI::Models::DecisionCreateParams::Question::Choice::Choice#value
            module Value
              extend OpenAI::Internal::Type::Union

              variant String

              variant OpenAI::Internal::Type::Boolean

              # @!method self.variants
              #   @return [Array(String, Boolean)]
            end
          end

          # @see OpenAI::Models::DecisionCreateParams::Question::Choice#instructions
          module Instructions
            extend OpenAI::Internal::Type::Union

            variant String

            variant(
              -> {
                OpenAI::Models::DecisionCreateParams::Question::Choice::Instructions::DecisionQuestionInputPartArray
              }
            )

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

            # @type [OpenAI::Internal::Type::Converter]
            DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
              union: -> { OpenAI::DecisionQuestionInputPart }
            ]
          end
        end

        class Score < OpenAI::Internal::Type::BaseModel
          # @!attribute instructions
          #
          #   @return [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          required :instructions, union: -> { OpenAI::DecisionCreateParams::Question::Score::Instructions }

          # @!attribute levels
          #
          #   @return [Array<OpenAI::Models::DecisionCreateParams::Question::Score::Level>]
          required(
            :levels,
            -> { OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionCreateParams::Question::Score::Level] }
          )

          # @!attribute type
          #   The type of the object. Always `score`.
          #
          #   @return [Symbol, :score]
          required :type, const: :score

          # @!attribute name
          #
          #   @return [String, nil]
          optional :name, String

          # @!method initialize(instructions:, levels:, name: nil, type: :score)
          #   Rate the input against the supplied ordered levels.
          #
          #   @param instructions [String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>]
          #
          #   @param levels [Array<OpenAI::Models::DecisionCreateParams::Question::Score::Level>]
          #
          #   @param name [String]
          #
          #   @param type [Symbol, :score]
          #     The type of the object. Always `score`.

          # @see OpenAI::Models::DecisionCreateParams::Question::Score#instructions
          module Instructions
            extend OpenAI::Internal::Type::Union

            variant String

            variant(
              -> {
                OpenAI::Models::DecisionCreateParams::Question::Score::Instructions::DecisionQuestionInputPartArray
              }
            )

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::DecisionQuestionInputText, OpenAI::Models::DecisionQuestionInputImage, OpenAI::Models::DecisionInputJSON>)]

            # @type [OpenAI::Internal::Type::Converter]
            DecisionQuestionInputPartArray = OpenAI::Internal::Type::ArrayOf[
              union: -> { OpenAI::DecisionQuestionInputPart }
            ]
          end

          class Level < OpenAI::Internal::Type::BaseModel
            # @!attribute label
            #
            #   @return [String]
            required :label, String

            # @!attribute description
            #
            #   @return [String, nil]
            optional :description, String

            # @!method initialize(label:, description: nil)
            #   @param label [String]
            #   @param description [String]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::DecisionCreateParams::Question::Predicate, OpenAI::Models::DecisionCreateParams::Question::Choice, OpenAI::Models::DecisionCreateParams::Question::Score)]
      end

      class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
        # @!attribute mode
        #   Controls whether OpenAI automatically creates an implicit cache breakpoint.
        #   Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        #   and writes up to the latest three explicit breakpoints in the request. With
        #   `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        #   latest four explicit breakpoints. If there are no explicit breakpoints, the
        #   request does not use prompt caching.
        #
        #   @return [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Mode, nil]
        optional :mode, enum: -> { OpenAI::DecisionCreateParams::PromptCacheOptions::Mode }, nil?: true

        # @!attribute ttl
        #   The minimum lifetime applied to every implicit and explicit cache breakpoint
        #   written by the request. Defaults to `30m`, which is currently the only supported
        #   value. The backend may retain cache entries for longer.
        #
        #   @return [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Ttl, nil]
        optional :ttl, enum: -> { OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl }

        # @!method initialize(mode: nil, ttl: nil)
        #   Options for prompt caching. Supported for `gpt-5.6` and later models. By
        #   default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        #   explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        #   request can write up to four breakpoints. For cache matching, OpenAI considers
        #   up to the latest 80 breakpoints in the conversation, without a content-block
        #   lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        #   `ttl` defaults to `30m`, which is currently the only supported value. See the
        #   [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        #   for current details.
        #
        #   @param mode [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Mode, nil]
        #     Controls whether OpenAI automatically creates an implicit cache breakpoint.
        #     Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        #     and writes up to the latest three explicit breakpoints in the request. With
        #     `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        #     latest four explicit breakpoints. If there are no explicit breakpoints, the
        #     request does not use prompt caching.
        #
        #   @param ttl [Symbol, OpenAI::Models::DecisionCreateParams::PromptCacheOptions::Ttl]
        #     The minimum lifetime applied to every implicit and explicit cache breakpoint
        #     written by the request. Defaults to `30m`, which is currently the only supported
        #     value. The backend may retain cache entries for longer.

        # Controls whether OpenAI automatically creates an implicit cache breakpoint.
        # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        # and writes up to the latest three explicit breakpoints in the request. With
        # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        # latest four explicit breakpoints. If there are no explicit breakpoints, the
        # request does not use prompt caching.
        #
        # @see OpenAI::Models::DecisionCreateParams::PromptCacheOptions#mode
        module Mode
          extend OpenAI::Internal::Type::Enum

          IMPLICIT = :implicit
          EXPLICIT = :explicit

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The minimum lifetime applied to every implicit and explicit cache breakpoint
        # written by the request. Defaults to `30m`, which is currently the only supported
        # value. The backend may retain cache entries for longer.
        #
        # @see OpenAI::Models::DecisionCreateParams::PromptCacheOptions#ttl
        module Ttl
          extend OpenAI::Internal::Type::Enum

          TTL_30M = :"30m"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
