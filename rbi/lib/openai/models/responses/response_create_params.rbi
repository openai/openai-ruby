# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.any(String, OpenAI::Models::Responses::ResponseInput)) }
        def input
        end

        sig do
          params(_: T.any(String, OpenAI::Models::Responses::ResponseInput))
            .returns(T.any(String, OpenAI::Models::Responses::ResponseInput))
        end
        def input=(_)
        end

        sig { returns(T.any(String, Symbol)) }
        def model
        end

        sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
        def model=(_)
        end

        sig { returns(T.nilable(T::Array[Symbol])) }
        def include
        end

        sig { params(_: T.nilable(T::Array[Symbol])).returns(T.nilable(T::Array[Symbol])) }
        def include=(_)
        end

        sig { returns(T.nilable(String)) }
        def instructions
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def instructions=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_output_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_output_tokens=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def parallel_tool_calls
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def parallel_tool_calls=(_)
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

        sig { returns(T.nilable(T::Boolean)) }
        def store
        end

        sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def store=(_)
        end

        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
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

        sig do
          returns(
            T.nilable(
              T.any(Symbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction)
            )
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
            T.nilable(
              T::Array[
              T.any(
                OpenAI::Models::Responses::FileSearchTool,
                OpenAI::Models::Responses::FunctionTool,
                OpenAI::Models::Responses::ComputerTool,
                OpenAI::Models::Responses::WebSearchTool
              )
              ]
            )
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

        sig { returns(T.nilable(Symbol)) }
        def truncation
        end

        sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
        def truncation=(_)
        end

        sig { returns(T.nilable(String)) }
        def user
        end

        sig { params(_: String).returns(String) }
        def user=(_)
        end

        sig do
          params(
            input: T.any(String, OpenAI::Models::Responses::ResponseInput),
            model: T.any(String, Symbol),
            include: T.nilable(T::Array[Symbol]),
            instructions: T.nilable(String),
            max_output_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            parallel_tool_calls: T.nilable(T::Boolean),
            previous_response_id: T.nilable(String),
            reasoning: T.nilable(OpenAI::Models::Reasoning),
            store: T.nilable(T::Boolean),
            temperature: T.nilable(Float),
            text: OpenAI::Models::Responses::ResponseTextConfig,
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
            truncation: T.nilable(Symbol),
            user: String,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          input:,
          model:,
          include: nil,
          instructions: nil,
          max_output_tokens: nil,
          metadata: nil,
          parallel_tool_calls: nil,
          previous_response_id: nil,
          reasoning: nil,
          store: nil,
          temperature: nil,
          text: nil,
          tool_choice: nil,
          tools: nil,
          top_p: nil,
          truncation: nil,
          user: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                input: T.any(String, OpenAI::Models::Responses::ResponseInput),
                model: T.any(String, Symbol),
                include: T.nilable(T::Array[Symbol]),
                instructions: T.nilable(String),
                max_output_tokens: T.nilable(Integer),
                metadata: T.nilable(OpenAI::Models::Metadata),
                parallel_tool_calls: T.nilable(T::Boolean),
                previous_response_id: T.nilable(String),
                reasoning: T.nilable(OpenAI::Models::Reasoning),
                store: T.nilable(T::Boolean),
                temperature: T.nilable(Float),
                text: OpenAI::Models::Responses::ResponseTextConfig,
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
                truncation: T.nilable(Symbol),
                user: String,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Input < OpenAI::Union
          abstract!

          class << self
            sig { override.returns([[NilClass, String], [NilClass, OpenAI::Models::Responses::ResponseInput]]) }
            private def variants
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
