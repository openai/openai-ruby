# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
                  OpenAI::Responses::EasyInputMessage,
                  OpenAI::Responses::ResponseInputItem::Message,
                  OpenAI::Responses::ResponseOutputMessage,
                  OpenAI::Responses::ResponseFileSearchToolCall,
                  OpenAI::Responses::ResponseComputerToolCall,
                  OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
                  OpenAI::Responses::ResponseFunctionWebSearch,
                  OpenAI::Responses::ResponseFunctionToolCall,
                  OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
                  OpenAI::Responses::ResponseReasoningItem,
                  OpenAI::Responses::ResponseInputItem::ItemReference
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
              OpenAI::ChatModel::OrSymbol,
              OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
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
        # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
        #   tokens in reasoning item outputs. This enables reasoning items to be used in
        #   multi-turn conversations when using the Responses API statelessly (like when
        #   the `store` parameter is set to `false`, or when an organization is enrolled
        #   in the zero data retention program).
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
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
        sig { returns(T.nilable(OpenAI::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::Reasoning::OrHash)).void }
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
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
            )
          )
        end
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
        sig { returns(T.nilable(OpenAI::Responses::ResponseTextConfig)) }
        attr_reader :text

        sig { params(text: OpenAI::Responses::ResponseTextConfig::OrHash).void }
        attr_writer :text

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceTypes,
                OpenAI::Responses::ToolChoiceFunction
              )
            )
          )
        end
        attr_reader :tool_choice

        sig do
          params(
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceTypes::OrHash,
                OpenAI::Responses::ToolChoiceFunction::OrHash
              )
          ).void
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
                  OpenAI::Responses::FileSearchTool,
                  OpenAI::Responses::FunctionTool,
                  OpenAI::Responses::ComputerTool,
                  OpenAI::Responses::WebSearchTool
                )
              ]
            )
          )
        end
        attr_reader :tools

        sig do
          params(
            tools:
              T::Array[
                T.any(
                  OpenAI::Responses::FileSearchTool::OrHash,
                  OpenAI::Responses::FunctionTool::OrHash,
                  OpenAI::Responses::ComputerTool::OrHash,
                  OpenAI::Responses::WebSearchTool::OrHash
                )
              ]
          ).void
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
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
            )
          )
        end
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
            input:
              T.any(
                String,
                T::Array[
                  T.any(
                    OpenAI::Responses::EasyInputMessage::OrHash,
                    OpenAI::Responses::ResponseInputItem::Message::OrHash,
                    OpenAI::Responses::ResponseOutputMessage::OrHash,
                    OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                    OpenAI::Responses::ResponseComputerToolCall::OrHash,
                    OpenAI::Responses::ResponseInputItem::ComputerCallOutput::OrHash,
                    OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                    OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                    OpenAI::Responses::ResponseInputItem::FunctionCallOutput::OrHash,
                    OpenAI::Responses::ResponseReasoningItem::OrHash,
                    OpenAI::Responses::ResponseInputItem::ItemReference::OrHash
                  )
                ]
              ),
            model:
              T.any(
                String,
                OpenAI::ChatModel::OrSymbol,
                OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
              ),
            include:
              T.nilable(
                T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
              ),
            instructions: T.nilable(String),
            max_output_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            parallel_tool_calls: T.nilable(T::Boolean),
            previous_response_id: T.nilable(String),
            reasoning: T.nilable(OpenAI::Reasoning::OrHash),
            service_tier:
              T.nilable(
                OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
              ),
            store: T.nilable(T::Boolean),
            temperature: T.nilable(Float),
            text: OpenAI::Responses::ResponseTextConfig::OrHash,
            tool_choice:
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceTypes::OrHash,
                OpenAI::Responses::ToolChoiceFunction::OrHash
              ),
            tools:
              T::Array[
                T.any(
                  OpenAI::Responses::FileSearchTool::OrHash,
                  OpenAI::Responses::FunctionTool::OrHash,
                  OpenAI::Responses::ComputerTool::OrHash,
                  OpenAI::Responses::WebSearchTool::OrHash
                )
              ],
            top_p: T.nilable(Float),
            truncation:
              T.nilable(
                OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
              ),
            user: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
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
          # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
          #   tokens in reasoning item outputs. This enables reasoning items to be used in
          #   multi-turn conversations when using the Responses API statelessly (like when
          #   the `store` parameter is set to `false`, or when an organization is enrolled
          #   in the zero data retention program).
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
        )
        end

        sig do
          override.returns(
            {
              input:
                T.any(
                  String,
                  T::Array[
                    T.any(
                      OpenAI::Responses::EasyInputMessage,
                      OpenAI::Responses::ResponseInputItem::Message,
                      OpenAI::Responses::ResponseOutputMessage,
                      OpenAI::Responses::ResponseFileSearchToolCall,
                      OpenAI::Responses::ResponseComputerToolCall,
                      OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
                      OpenAI::Responses::ResponseFunctionWebSearch,
                      OpenAI::Responses::ResponseFunctionToolCall,
                      OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
                      OpenAI::Responses::ResponseReasoningItem,
                      OpenAI::Responses::ResponseInputItem::ItemReference
                    )
                  ]
                ),
              model:
                T.any(
                  String,
                  OpenAI::ChatModel::OrSymbol,
                  OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol
                ),
              include:
                T.nilable(
                  T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
                ),
              instructions: T.nilable(String),
              max_output_tokens: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              parallel_tool_calls: T.nilable(T::Boolean),
              previous_response_id: T.nilable(String),
              reasoning: T.nilable(OpenAI::Reasoning),
              service_tier:
                T.nilable(
                  OpenAI::Responses::ResponseCreateParams::ServiceTier::OrSymbol
                ),
              store: T.nilable(T::Boolean),
              temperature: T.nilable(Float),
              text: OpenAI::Responses::ResponseTextConfig,
              tool_choice:
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceTypes,
                  OpenAI::Responses::ToolChoiceFunction
                ),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Responses::FileSearchTool,
                    OpenAI::Responses::FunctionTool,
                    OpenAI::Responses::ComputerTool,
                    OpenAI::Responses::WebSearchTool
                  )
                ],
              top_p: T.nilable(Float),
              truncation:
                T.nilable(
                  OpenAI::Responses::ResponseCreateParams::Truncation::OrSymbol
                ),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

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

          Variants =
            T.type_alias do
              T.any(
                String,
                T::Array[
                  T.any(
                    OpenAI::Responses::EasyInputMessage,
                    OpenAI::Responses::ResponseInputItem::Message,
                    OpenAI::Responses::ResponseOutputMessage,
                    OpenAI::Responses::ResponseFileSearchToolCall,
                    OpenAI::Responses::ResponseComputerToolCall,
                    OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
                    OpenAI::Responses::ResponseFunctionWebSearch,
                    OpenAI::Responses::ResponseFunctionToolCall,
                    OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
                    OpenAI::Responses::ResponseReasoningItem,
                    OpenAI::Responses::ResponseInputItem::ItemReference
                  )
                ]
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ResponseCreateParams::Input::Variants]
            )
          end
          def self.variants
          end
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
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Responses::ResponseCreateParams::ServiceTier
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          DEFAULT =
            T.let(
              :default,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )
          FLEX =
            T.let(
              :flex,
              OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::ServiceTier::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ToolChoiceOptions::TaggedSymbol,
                OpenAI::Responses::ToolChoiceTypes,
                OpenAI::Responses::ToolChoiceFunction
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::ToolChoice::Variants
              ]
            )
          end
          def self.variants
          end
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
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseCreateParams::Truncation)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::ResponseCreateParams::Truncation::TaggedSymbol
            )
          DISABLED =
            T.let(
              :disabled,
              OpenAI::Responses::ResponseCreateParams::Truncation::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseCreateParams::Truncation::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
