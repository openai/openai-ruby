# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        sig do
          returns(
            T.any(
              String,
              T::Array[
                T.any(
                  OpenAI::Models::Responses::EasyInputMessage,
                  OpenAI::Models::Responses::ResponseInputItem::Message,
                  OpenAI::Models::Responses::ResponseOutputMessage,
                  OpenAI::Models::Responses::ResponseFileSearchToolCall,
                  OpenAI::Models::Responses::ResponseComputerToolCall,
                  OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
                  OpenAI::Models::Responses::ResponseFunctionWebSearch,
                  OpenAI::Models::Responses::ResponseFunctionToolCall,
                  OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
                  OpenAI::Models::Responses::ResponseReasoningItem,
                  OpenAI::Models::Responses::ResponseInputItem::ItemReference
                )
              ]
            )
          )
        end
        attr_accessor :input

        # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
        # wide range of models with different capabilities, performance characteristics,
        # and price points. Refer to the
        # [model guide](https://platform.openai.com/docs/models) to browse and compare
        # available models.
        sig do
          returns(
            T.any(
              String,
              OpenAI::Models::ChatModel::OrSymbol,
              OpenAI::Models::ResponsesModel::ResponsesOnlyModel::OrSymbol
            )
          )
        end
        attr_accessor :model

        # Specify additional output data to include in the model response. Currently
        # supported values are:
        #
        # - `file_search_call.results`: Include the search results of the file search tool
        #   call.
        # - `message.input_image.image_url`: Include image urls from the input message.
        # - `computer_call_output.output.image_url`: Include image urls from the computer
        #   call output.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol])) }
        attr_accessor :include

        # Inserts a system (or developer) message as the first item in the model's
        # context.
        #
        # When using along with `previous_response_id`, the instructions from a previous
        # response will not be carried over to the next response. This makes it simple to
        # swap out system (or developer) messages in new responses.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # An upper bound for the number of tokens that can be generated for a response,
        # including visible output tokens and
        # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_output_tokens

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # Whether to allow the model to run tool calls in parallel.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :parallel_tool_calls

        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_response_id

        # **o-series models only**
        #
        # Configuration options for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(OpenAI::Models::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(T.any(OpenAI::Models::Reasoning, OpenAI::Internal::AnyHash))).void }
        attr_writer :reasoning

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::OrSymbol)) }
        attr_accessor :service_tier

        # Whether to store the generated model response for later retrieval via API.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :store

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic. We generally recommend altering this or `top_p` but
        # not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # Configuration options for a text response from the model. Can be plain text or
        # structured JSON data. Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseTextConfig)) }
        attr_reader :text

        sig { params(text: T.any(OpenAI::Models::Responses::ResponseTextConfig, OpenAI::Internal::AnyHash)).void }
        attr_writer :text

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Models::Responses::ToolChoiceTypes,
                OpenAI::Models::Responses::ToolChoiceFunction
              )
            )
          )
        end
        attr_reader :tool_choice

        sig do
          params(
            tool_choice: T.any(
              OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
              OpenAI::Models::Responses::ToolChoiceTypes,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Responses::ToolChoiceFunction
            )
          )
            .void
        end
        attr_writer :tool_choice

        # An array of tools the model may call while generating a response. You can
        # specify which tool to use by setting the `tool_choice` parameter.
        #
        # The two categories of tools you can provide the model are:
        #
        # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
        #   capabilities, like
        #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
        #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
        #   Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        # - **Function calls (custom tools)**: Functions that are defined by you, enabling
        #   the model to call your own code. Learn more about
        #   [function calling](https://platform.openai.com/docs/guides/function-calling).
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
        attr_reader :tools

        sig do
          params(
            tools: T::Array[
              T.any(
                OpenAI::Models::Responses::FileSearchTool,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::Responses::FunctionTool,
                OpenAI::Models::Responses::ComputerTool,
                OpenAI::Models::Responses::WebSearchTool
              )
            ]
          )
            .void
        end
        attr_writer :tools

        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or `temperature` but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseCreateParams::Truncation::OrSymbol)) }
        attr_accessor :truncation

        # A unique identifier representing your end-user, which can help OpenAI to monitor
        # and detect abuse.
        # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
        sig { returns(T.nilable(String)) }
        attr_reader :user

        sig { params(user: String).void }
        attr_writer :user

        sig do
          params(
            input: T.any(
              String,
              T::Array[
                T.any(
                  OpenAI::Models::Responses::EasyInputMessage,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Responses::ResponseInputItem::Message,
                  OpenAI::Models::Responses::ResponseOutputMessage,
                  OpenAI::Models::Responses::ResponseFileSearchToolCall,
                  OpenAI::Models::Responses::ResponseComputerToolCall,
                  OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
                  OpenAI::Models::Responses::ResponseFunctionWebSearch,
                  OpenAI::Models::Responses::ResponseFunctionToolCall,
                  OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
                  OpenAI::Models::Responses::ResponseReasoningItem,
                  OpenAI::Models::Responses::ResponseInputItem::ItemReference
                )
              ]
            ),
            model: T.any(
              String,
              OpenAI::Models::ChatModel::OrSymbol,
              OpenAI::Models::ResponsesModel::ResponsesOnlyModel::OrSymbol
            ),
            include: T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol]),
            instructions: T.nilable(String),
            max_output_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            parallel_tool_calls: T.nilable(T::Boolean),
            previous_response_id: T.nilable(String),
            reasoning: T.nilable(T.any(OpenAI::Models::Reasoning, OpenAI::Internal::AnyHash)),
            service_tier: T.nilable(OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::OrSymbol),
            store: T.nilable(T::Boolean),
            temperature: T.nilable(Float),
            text: T.any(OpenAI::Models::Responses::ResponseTextConfig, OpenAI::Internal::AnyHash),
            tool_choice: T.any(
              OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
              OpenAI::Models::Responses::ToolChoiceTypes,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Responses::ToolChoiceFunction
            ),
            tools: T::Array[
              T.any(
                OpenAI::Models::Responses::FileSearchTool,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::Responses::FunctionTool,
                OpenAI::Models::Responses::ComputerTool,
                OpenAI::Models::Responses::WebSearchTool
              )
            ],
            top_p: T.nilable(Float),
            truncation: T.nilable(OpenAI::Models::Responses::ResponseCreateParams::Truncation::OrSymbol),
            user: String,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(
          # Text, image, or file inputs to the model, used to generate a response.
          #
          # Learn more:
          #
          # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          # - [Image inputs](https://platform.openai.com/docs/guides/images)
          # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
          # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
          # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
          input:,
          # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          model:,
          # Specify additional output data to include in the model response. Currently
          # supported values are:
          #
          # - `file_search_call.results`: Include the search results of the file search tool
          #   call.
          # - `message.input_image.image_url`: Include image urls from the input message.
          # - `computer_call_output.output.image_url`: Include image urls from the computer
          #   call output.
          include: nil,
          # Inserts a system (or developer) message as the first item in the model's
          # context.
          #
          # When using along with `previous_response_id`, the instructions from a previous
          # response will not be carried over to the next response. This makes it simple to
          # swap out system (or developer) messages in new responses.
          instructions: nil,
          # An upper bound for the number of tokens that can be generated for a response,
          # including visible output tokens and
          # [reasoning tokens](https://platform.openai.com/docs/guides/reasoning).
          max_output_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # Whether to allow the model to run tool calls in parallel.
          parallel_tool_calls: nil,
          # The unique ID of the previous response to the model. Use this to create
          # multi-turn conversations. Learn more about
          # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
          previous_response_id: nil,
          # **o-series models only**
          #
          # Configuration options for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          reasoning: nil,
          # Specifies the latency tier to use for processing the request. This parameter is
          # relevant for customers subscribed to the scale tier service:
          #
          # - If set to 'auto', and the Project is Scale tier enabled, the system will
          #   utilize scale tier credits until they are exhausted.
          # - If set to 'auto', and the Project is not Scale tier enabled, the request will
          #   be processed using the default service tier with a lower uptime SLA and no
          #   latency guarentee.
          # - If set to 'default', the request will be processed using the default service
          #   tier with a lower uptime SLA and no latency guarentee.
          # - If set to 'flex', the request will be processed with the Flex Processing
          #   service tier.
          #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
          # - When not set, the default behavior is 'auto'.
          #
          # When this parameter is set, the response body will include the `service_tier`
          # utilized.
          service_tier: nil,
          # Whether to store the generated model response for later retrieval via API.
          store: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic. We generally recommend altering this or `top_p` but
          # not both.
          temperature: nil,
          # Configuration options for a text response from the model. Can be plain text or
          # structured JSON data. Learn more:
          #
          # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
          text: nil,
          # How the model should select which tool (or tools) to use when generating a
          # response. See the `tools` parameter to see how to specify which tools the model
          # can call.
          tool_choice: nil,
          # An array of tools the model may call while generating a response. You can
          # specify which tool to use by setting the `tool_choice` parameter.
          #
          # The two categories of tools you can provide the model are:
          #
          # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
          #   capabilities, like
          #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
          #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
          #   Learn more about
          #   [built-in tools](https://platform.openai.com/docs/guides/tools).
          # - **Function calls (custom tools)**: Functions that are defined by you, enabling
          #   the model to call your own code. Learn more about
          #   [function calling](https://platform.openai.com/docs/guides/function-calling).
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or `temperature` but not both.
          top_p: nil,
          # The truncation strategy to use for the model response.
          #
          # - `auto`: If the context of this response and previous ones exceeds the model's
          #   context window size, the model will truncate the response to fit the context
          #   window by dropping input items in the middle of the conversation.
          # - `disabled` (default): If a model response will exceed the context window size
          #   for a model, the request will fail with a 400 error.
          truncation: nil,
          # A unique identifier representing your end-user, which can help OpenAI to monitor
          # and detect abuse.
          # [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
          user: nil,
          request_options: {}
        ); end
        sig do
          override
            .returns(
              {
                input: T.any(
                  String,
                  T::Array[
                    T.any(
                      OpenAI::Models::Responses::EasyInputMessage,
                      OpenAI::Models::Responses::ResponseInputItem::Message,
                      OpenAI::Models::Responses::ResponseOutputMessage,
                      OpenAI::Models::Responses::ResponseFileSearchToolCall,
                      OpenAI::Models::Responses::ResponseComputerToolCall,
                      OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
                      OpenAI::Models::Responses::ResponseFunctionWebSearch,
                      OpenAI::Models::Responses::ResponseFunctionToolCall,
                      OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
                      OpenAI::Models::Responses::ResponseReasoningItem,
                      OpenAI::Models::Responses::ResponseInputItem::ItemReference
                    )
                  ]
                ),
                model: T.any(
                  String,
                  OpenAI::Models::ChatModel::OrSymbol,
                  OpenAI::Models::ResponsesModel::ResponsesOnlyModel::OrSymbol
                ),
                include: T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol]),
                instructions: T.nilable(String),
                max_output_tokens: T.nilable(Integer),
                metadata: T.nilable(T::Hash[Symbol, String]),
                parallel_tool_calls: T.nilable(T::Boolean),
                previous_response_id: T.nilable(String),
                reasoning: T.nilable(OpenAI::Models::Reasoning),
                service_tier: T.nilable(OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::OrSymbol),
                store: T.nilable(T::Boolean),
                temperature: T.nilable(Float),
                text: OpenAI::Models::Responses::ResponseTextConfig,
                tool_choice: T.any(
                  OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol,
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
                truncation: T.nilable(OpenAI::Models::Responses::ResponseCreateParams::Truncation::OrSymbol),
                user: String,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        # Text, image, or file inputs to the model, used to generate a response.
        #
        # Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Image inputs](https://platform.openai.com/docs/guides/images)
        # - [File inputs](https://platform.openai.com/docs/guides/pdf-files)
        # - [Conversation state](https://platform.openai.com/docs/guides/conversation-state)
        # - [Function calling](https://platform.openai.com/docs/guides/function-calling)
        module Input
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns(
                [
                  String,
                  T::Array[
                                    T.any(
                                      OpenAI::Models::Responses::EasyInputMessage,
                                      OpenAI::Models::Responses::ResponseInputItem::Message,
                                      OpenAI::Models::Responses::ResponseOutputMessage,
                                      OpenAI::Models::Responses::ResponseFileSearchToolCall,
                                      OpenAI::Models::Responses::ResponseComputerToolCall,
                                      OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput,
                                      OpenAI::Models::Responses::ResponseFunctionWebSearch,
                                      OpenAI::Models::Responses::ResponseFunctionToolCall,
                                      OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput,
                                      OpenAI::Models::Responses::ResponseReasoningItem,
                                      OpenAI::Models::Responses::ResponseInputItem::ItemReference
                                    )
                                  ]
                ]
              )
          end
          def self.variants; end
        end

        # Specifies the latency tier to use for processing the request. This parameter is
        # relevant for customers subscribed to the scale tier service:
        #
        # - If set to 'auto', and the Project is Scale tier enabled, the system will
        #   utilize scale tier credits until they are exhausted.
        # - If set to 'auto', and the Project is not Scale tier enabled, the request will
        #   be processed using the default service tier with a lower uptime SLA and no
        #   latency guarentee.
        # - If set to 'default', the request will be processed using the default service
        #   tier with a lower uptime SLA and no latency guarentee.
        # - If set to 'flex', the request will be processed with the Flex Processing
        #   service tier.
        #   [Learn more](https://platform.openai.com/docs/guides/flex-processing).
        # - When not set, the default behavior is 'auto'.
        #
        # When this parameter is set, the response body will include the `service_tier`
        # utilized.
        module ServiceTier
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO = T.let(:auto, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol)
          DEFAULT = T.let(:default, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol)
          FLEX = T.let(:flex, OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol]) }
          def self.values; end
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ToolChoiceOptions::TaggedSymbol, OpenAI::Models::Responses::ToolChoiceTypes, OpenAI::Models::Responses::ToolChoiceFunction]
              )
          end
          def self.variants; end
        end

        # The truncation strategy to use for the model response.
        #
        # - `auto`: If the context of this response and previous ones exceeds the model's
        #   context window size, the model will truncate the response to fit the context
        #   window by dropping input items in the middle of the conversation.
        # - `disabled` (default): If a model response will exceed the context window size
        #   for a model, the request will fail with a 400 error.
        module Truncation
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseCreateParams::Truncation) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO = T.let(:auto, OpenAI::Models::Responses::ResponseCreateParams::Truncation::TaggedSymbol)
          DISABLED = T.let(:disabled, OpenAI::Models::Responses::ResponseCreateParams::Truncation::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseCreateParams::Truncation::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
