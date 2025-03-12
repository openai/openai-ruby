# typed: strong

module OpenAI
  module Models
    module Responses
      class Response < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(Float) }
        def created_at
        end

        sig { params(_: Float).returns(Float) }
        def created_at=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseError)) }
        def error
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Responses::ResponseError))
            .returns(T.nilable(OpenAI::Models::Responses::ResponseError))
        end
        def error=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails)) }
        def incomplete_details
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails))
            .returns(T.nilable(OpenAI::Models::Responses::Response::IncompleteDetails))
        end
        def incomplete_details=(_)
        end

        sig { returns(T.nilable(String)) }
        def instructions
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def instructions=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

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

        sig { returns(T::Boolean) }
        def parallel_tool_calls
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def parallel_tool_calls=(_)
        end

        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
        end

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

        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_output_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_output_tokens=(_)
        end

        sig { returns(T.nilable(String)) }
        def previous_response_id
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def previous_response_id=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Reasoning)) }
        def reasoning
        end

        sig { params(_: T.nilable(OpenAI::Models::Reasoning)).returns(T.nilable(OpenAI::Models::Reasoning)) }
        def reasoning=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseTextConfig)) }
        def text
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseTextConfig)
            .returns(OpenAI::Models::Responses::ResponseTextConfig)
        end
        def text=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def truncation
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def truncation=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseUsage)) }
        def usage
        end

        sig { params(_: OpenAI::Models::Responses::ResponseUsage).returns(OpenAI::Models::Responses::ResponseUsage) }
        def usage=(_)
        end

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
          sig { returns(T.nilable(Symbol)) }
          def reason
          end

          sig { params(_: Symbol).returns(Symbol) }
          def reason=(_)
          end

          sig { params(reason: Symbol).returns(T.attached_class) }
          def self.new(reason: nil)
          end

          sig { override.returns({reason: Symbol}) }
          def to_hash
          end

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

        class Model < OpenAI::Union
          abstract!

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        class ToolChoice < OpenAI::Union
          abstract!

          class << self
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
