# typed: strong

module OpenAI
  module Models
    module Responses
      class Response < OpenAI::BaseModel
        # Unique identifier for this Response.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # Unix timestamp (in seconds) of when this Response was created.
        sig { returns(Float) }
        def created_at
        end

        sig { params(_: Float).returns(Float) }
        def created_at=(_)
        end

        # An error object returned when the model fails to generate a Response.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseError)) }
        def error
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Responses::ResponseError))
            .returns(T.nilable(OpenAI::Models::Responses::ResponseError))
        end
        def error=(_)
        end

        # Details about why the response is incomplete.
        sig { returns(T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails)) }
        def incomplete_details
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails))
            .returns(T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails))
        end
        def incomplete_details=(_)
        end

        # Inserts a system (or developer) message as the first item in the model's
        #   context.
        #
        #   When using along with `previous_response_id`, the instructions from a previous
        #   response will be not be carried over to the next response. This makes it simple
        #   to swap out system (or developer) messages in new responses.
        sig { returns(T.nilable(String)) }
        def instructions
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def instructions=(_)
        end

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        # The object type of this resource - always set to `response`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

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
        def output
        end

        sig do
          params(
            _: T::Array[
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
            .returns(
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
        def output=(_)
        end

        # Whether to allow the model to run tool calls in parallel.
        sig { returns(T::Boolean) }
        def parallel_tool_calls
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def parallel_tool_calls=(_)
        end

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic. We generally recommend altering this or `top_p` but
        #   not both.
        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
        end

        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        sig do
          returns(
            T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction)
          )
        end
        def tool_choice
        end

        sig do
          params(
            _: T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction)
          )
            .returns(
              T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction)
            )
        end
        def tool_choice=(_)
        end

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
        def tools
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Responses::FileSearchTool,
              OpenAI::Models::Responses::FunctionTool,
              OpenAI::Models::Responses::ComputerTool,
              OpenAI::Models::Responses::WebSearchTool
            )
            ]
          )
            .returns(
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
        def tools=(_)
        end

        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or `temperature` but not both.
        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        # An upper bound for the number of tokens that can be generated for a response,
        #   including visible output tokens and
        #   [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(Integer)) }
        def max_output_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_output_tokens=(_)
        end

        # The unique ID of the previous response to the model. Use this to create
        #   multi-turn conversations. Learn more about
        #   [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        sig { returns(T.nilable(String)) }
        def previous_response_id
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def previous_response_id=(_)
        end

        # **o-series models only**
        #
        #   Configuration options for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(OpenAI::Models::Reasoning)) }
        def reasoning
        end

        sig { params(_: T.nilable(OpenAI::Models::Reasoning)).returns(T.nilable(OpenAI::Models::Reasoning)) }
        def reasoning=(_)
        end

        # The status of the response generation. One of `completed`, `failed`,
        #   `in_progress`, or `incomplete`.
        sig { returns(T.nilable(Symbol)) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # Configuration options for a text response from the model. Can be plain text or
        #   structured JSON data. Learn more:
        #
        #   - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        #   - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseTextConfig)) }
        def text
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseTextConfig)
            .returns(OpenAI::Models::Responses::ResponseTextConfig)
        end
        def text=(_)
        end

        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        sig { returns(T.nilable(Symbol)) }
        def truncation
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def truncation=(_)
        end

        # Represents token usage details including input tokens, output tokens, a
        #   breakdown of output tokens, and the total tokens used.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseUsage)) }
        def usage
        end

        sig { params(_: OpenAI::Models::Responses::ResponseUsage).returns(OpenAI::Models::Responses::ResponseUsage) }
        def usage=(_)
        end

        # A unique identifier representing your end-user, which can help OpenAI to monitor
        #   and detect abuse.
        #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        sig { returns(T.nilable(String)) }
        def user
        end

        sig { params(_: String).returns(String) }
        def user=(_)
        end

        sig do
          params(
            id: String,
            created_at: Float,
            error: T.nilable(OpenAI::Models::Responses::ResponseError),
            incomplete_details: T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails),
            instructions: T.nilable(String),
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: T.any(String, Symbol),
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
            tool_choice: T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction),
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
            status: Symbol,
            text: OpenAI::Models::Responses::ResponseTextConfig,
            truncation: T.nilable(Symbol),
            usage: OpenAI::Models::Responses::ResponseUsage,
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
                metadata: T.nilable(OpenAI::Models::Metadata),
                model: T.any(String, Symbol),
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
                tool_choice: T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction),
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
                status: Symbol,
                text: OpenAI::Models::Responses::ResponseTextConfig,
                truncation: T.nilable(Symbol),
                usage: OpenAI::Models::Responses::ResponseUsage,
                user: String
              }
            )
        end
        def to_hash
        end

        class IncompleteDetails < OpenAI::BaseModel
          # The reason why the response is incomplete.
          sig { returns(T.nilable(Symbol)) }
          def reason
          end

          sig { params(_: Symbol).returns(Symbol) }
          def reason=(_)
          end

          # Details about why the response is incomplete.
          sig { params(reason: Symbol).returns(T.attached_class) }
          def self.new(reason: nil)
          end

          sig { override.returns({reason: Symbol}) }
          def to_hash
          end

          # The reason why the response is incomplete.
          class Reason < OpenAI::Enum
            abstract!

            MAX_OUTPUT_TOKENS = :max_output_tokens
            CONTENT_FILTER = :content_filter

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end

        # Model ID used to generate the response, like `gpt-4o` or `o1`. OpenAI offers a
        #   wide range of models with different capabilities, performance characteristics,
        #   and price points. Refer to the
        #   [model guide](https://platform.openai.com/docs/models) to browse and compare
        #   available models.
        class Model < OpenAI::Union
          abstract!

          class << self
            # @api private
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        #   response. See the `tools` parameter to see how to specify which tools the model
        #   can call.
        class ToolChoice < OpenAI::Union
          abstract!

          class << self
            # @api private
            sig do
              override
                .returns(
                  [[NilClass, Symbol], [NilClass, OpenAI::Models::Responses::ToolChoiceTypes], [NilClass, OpenAI::Models::Responses::ToolChoiceFunction]]
                )
            end
            private def variants
            end
          end
        end

        # The truncation strategy to use for the model response.
        #
        #   - `auto`: If the context of this response and previous ones exceeds the model's
        #     context window size, the model will truncate the response to fit the context
        #     window by dropping input items in the middle of the conversation.
        #   - `disabled` (default): If a model response will exceed the context window size
        #     for a model, the request will fail with a 400 error.
        class Truncation < OpenAI::Enum
          abstract!

          AUTO = T.let(:auto, T.nilable(Symbol))
          DISABLED = T.let(:disabled, T.nilable(Symbol))

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
