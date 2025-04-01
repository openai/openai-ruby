# typed: strong

module OpenAI
  module Models
    module Responses
      class Response < OpenAI::BaseModel
        # Unique identifier for this Response.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (in seconds) of when this Response was created.
        sig { returns(Float) }
        attr_accessor :created_at

        # An error object returned when the model fails to generate a Response.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseError)) }
        attr_reader :error

        sig { params(error: T.nilable(T.any(OpenAI::Models::Responses::ResponseError, OpenAI::Util::AnyHash))).void }
        attr_writer :error

        # Details about why the response is incomplete.
        sig { returns(T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails)) }
        attr_reader :incomplete_details

        sig do
          params(
            incomplete_details: T.nilable(T.any(OpenAI::Models::Responses::Response::IncompleteDetails, OpenAI::Util::AnyHash))
          )
            .void
        end
        attr_writer :incomplete_details

        # Inserts a system (or developer) message as the first item in the model's
        #   context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will not be carried over to the next response. This makes it simple to
        #   swap out system (or developer) messages in new responses.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        sig do
          returns(
            T.any(String, OpenAI::Models::ChatModel::TaggedSymbol, OpenAI::Models::ResponsesModel::TaggedSymbol)
          )
        end
        attr_accessor :model

        # The object type of this resource - always set to `response`.
        sig { returns(Symbol) }
        attr_accessor :object

        # An array of content items generated by the model.
        #
        #   - The length and order of items in the `output` array is dependent on the
        #     model's response.
        #   - Rather than accessing the first item in the `output` array and assuming it's
        #     an `assistant` message with the content generated by the model, you might
        #     consider using the `output_text` property where supported in SDKs.
        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseReasoningItem
            )
            ]
          )
        end
        attr_accessor :output

        # Whether to allow the model to run tool calls in parallel.
        sig { returns(T::Boolean) }
        attr_accessor :parallel_tool_calls

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        sig do
          returns(
            T.any(
              OpenAI::Models::Responses::ToolChoiceOptions::TaggedSymbol,
              OpenAI::Models::Responses::ToolChoiceTypes,
              OpenAI::Models::Responses::ToolChoiceFunction
            )
          )
        end
        attr_accessor :tool_choice

        # An array of tools the model may call while generating a response. You can
        #   specify which tool to use by setting the `tool_choice` parameter.
        #
        #   The two categories of tools you can provide the model are:
        #
        #   - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #     capabilities, like
        #     [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #     [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #     Learn more about
        #     [built-in tools](https://platform.openai.com/docs/guides/tools).
        #   - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #     the model to call your own code. Learn more about
        #     [function calling](https://platform.openai.com/docs/guides/function-calling).
        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Responses::FileSearchTool,
              OpenAI::Models::Responses::FunctionTool,
              OpenAI::Models::Responses::ComputerTool,
              OpenAI::Models::Responses::WebSearchTool
            )
            ]
          )
        end
        attr_accessor :tools

        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

        # An upper bound for the number of tokens that can be generated for a response,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_output_tokens

        # The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_response_id

        # **o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(OpenAI::Models::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(T.any(OpenAI::Models::Reasoning, OpenAI::Util::AnyHash))).void }
        attr_writer :reasoning

        # The status of the response generation. One of `completed`, `failed`,
        #   `in_progress`, or `incomplete`.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseStatus::TaggedSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Models::Responses::ResponseStatus::OrSymbol).void }
        attr_writer :status

        # Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseTextConfig)) }
        attr_reader :text

        sig { params(text: T.any(OpenAI::Models::Responses::ResponseTextConfig, OpenAI::Util::AnyHash)).void }
        attr_writer :text

        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        sig { returns(T.nilable(OpenAI::Models::Responses::Response::Truncation::TaggedSymbol)) }
        attr_accessor :truncation

        # Represents token usage details including input tokens, output tokens, a
        #   breakdown of output tokens, and the total tokens used.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseUsage)) }
        attr_reader :usage

        sig { params(usage: T.any(OpenAI::Models::Responses::ResponseUsage, OpenAI::Util::AnyHash)).void }
        attr_writer :usage

        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        sig { returns(T.nilable(String)) }
        attr_reader :user

        sig { params(user: String).void }
        attr_writer :user

        sig do
          params(
            id: String,
            created_at: Float,
            error: T.nilable(T.any(OpenAI::Models::Responses::ResponseError, OpenAI::Util::AnyHash)),
            incomplete_details: T.nilable(T.any(OpenAI::Models::Responses::Response::IncompleteDetails, OpenAI::Util::AnyHash)),
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.any(String, OpenAI::Models::ChatModel::OrSymbol, OpenAI::Models::ResponsesModel::OrSymbol),
            output: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseReasoningItem
            )
            ],
            parallel_tool_calls: T::Boolean,
            temperature: T.nilable(Float),
            tool_choice: T.any(
              OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
              OpenAI::Models::Responses::ToolChoiceTypes,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Responses::ToolChoiceFunction
            ),
            tools: T::Array[
            T.any(
              OpenAI::Models::Responses::FileSearchTool,
              OpenAI::Util::AnyHash,
              OpenAI::Models::Responses::FunctionTool,
              OpenAI::Models::Responses::ComputerTool,
              OpenAI::Models::Responses::WebSearchTool
            )
            ],
            top_p: T.nilable(Float),
            max_output_tokens: T.nilable(Integer),
            previous_response_id: T.nilable(String),
            reasoning: T.nilable(T.any(OpenAI::Models::Reasoning, OpenAI::Util::AnyHash)),
            status: OpenAI::Models::Responses::ResponseStatus::OrSymbol,
            text: T.any(OpenAI::Models::Responses::ResponseTextConfig, OpenAI::Util::AnyHash),
            truncation: T.nilable(OpenAI::Models::Responses::Response::Truncation::OrSymbol),
            usage: T.any(OpenAI::Models::Responses::ResponseUsage, OpenAI::Util::AnyHash),
            user: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          error:,
          incomplete_details:,
          instructions:,
          metadata:,
          model:,
          output:,
          parallel_tool_calls:,
          temperature:,
          tool_choice:,
          tools:,
          top_p:,
          max_output_tokens: nil,
          previous_response_id: nil,
          reasoning: nil,
          status: nil,
          text: nil,
          truncation: nil,
          usage: nil,
          user: nil,
          object: :response
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Float,
                error: T.nilable(OpenAI::Models::Responses::ResponseError),
                incomplete_details: T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails),
                instructions: T.nilable(String),
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: T.any(String, OpenAI::Models::ChatModel::TaggedSymbol, OpenAI::Models::ResponsesModel::TaggedSymbol),
                object: Symbol,
                output: T::Array[
                T.any(
                  OpenAI::Models::Responses::ResponseOutputMessage,
                  OpenAI::Models::Responses::ResponseFileSearchToolCall,
                  OpenAI::Models::Responses::ResponseFunctionToolCall,
                  OpenAI::Models::Responses::ResponseFunctionWebSearch,
                  OpenAI::Models::Responses::ResponseComputerToolCall,
                  OpenAI::Models::Responses::ResponseReasoningItem
                )
                ],
                parallel_tool_calls: T::Boolean,
                temperature: T.nilable(Float),
                tool_choice: T.any(
                  OpenAI::Models::Responses::ToolChoiceOptions::TaggedSymbol,
                  OpenAI::Models::Responses::ToolChoiceTypes,
                  OpenAI::Models::Responses::ToolChoiceFunction
                ),
                tools: T::Array[
                T.any(
                  OpenAI::Models::Responses::FileSearchTool,
                  OpenAI::Models::Responses::FunctionTool,
                  OpenAI::Models::Responses::ComputerTool,
                  OpenAI::Models::Responses::WebSearchTool
                )
                ],
                top_p: T.nilable(Float),
                max_output_tokens: T.nilable(Integer),
                previous_response_id: T.nilable(String),
                reasoning: T.nilable(OpenAI::Models::Reasoning),
                status: OpenAI::Models::Responses::ResponseStatus::TaggedSymbol,
                text: OpenAI::Models::Responses::ResponseTextConfig,
                truncation: T.nilable(OpenAI::Models::Responses::Response::Truncation::TaggedSymbol),
                usage: OpenAI::Models::Responses::ResponseUsage,
                user: String
              }
            )
        end
        def to_hash
        end

        class IncompleteDetails < OpenAI::BaseModel
          # The reason why the response is incomplete.
          sig { returns(T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails::Reason::TaggedSymbol)) }
          attr_reader :reason

          sig { params(reason: OpenAI::Models::Responses::Response::IncompleteDetails::Reason::OrSymbol).void }
          attr_writer :reason

          # Details about why the response is incomplete.
          sig do
            params(reason: OpenAI::Models::Responses::Response::IncompleteDetails::Reason::OrSymbol)
              .returns(T.attached_class)
          end
          def self.new(reason: nil)
          end

          sig { override.returns({reason: OpenAI::Models::Responses::Response::IncompleteDetails::Reason::TaggedSymbol}) }
          def to_hash
          end

          # The reason why the response is incomplete.
          module Reason
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Responses::Response::IncompleteDetails::Reason) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::Response::IncompleteDetails::Reason::TaggedSymbol) }

            MAX_OUTPUT_TOKENS =
              T.let(:max_output_tokens, OpenAI::Models::Responses::Response::IncompleteDetails::Reason::TaggedSymbol)
            CONTENT_FILTER =
              T.let(:content_filter, OpenAI::Models::Responses::Response::IncompleteDetails::Reason::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Responses::Response::IncompleteDetails::Reason::TaggedSymbol]) }
            def self.values
            end
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        module ToolChoice
          extend OpenAI::Union

          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ToolChoiceOptions::TaggedSymbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction]
              )
          end
          def self.variants
          end
        end

        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        module Truncation
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::Response::Truncation) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::Response::Truncation::TaggedSymbol) }

          AUTO = T.let(:auto, OpenAI::Models::Responses::Response::Truncation::TaggedSymbol)
          DISABLED = T.let(:disabled, OpenAI::Models::Responses::Response::Truncation::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::Response::Truncation::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
