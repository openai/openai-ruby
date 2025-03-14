# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunCreateParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # The ID of the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
          #   execute this run.
          sig { returns(String) }
          def assistant_id
          end

          sig { params(_: String).returns(String) }
          def assistant_id=(_)
          end

          # A list of additional fields to include in the response. Currently the only
          #   supported value is `step_details.tool_calls[*].file_search.results[*].content`
          #   to fetch the file search result content.
          #
          #   See the
          #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #   for more information.
          sig { returns(T.nilable(T::Array[Symbol])) }
          def include
          end

          sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
          def include=(_)
          end

          # Appends additional instructions at the end of the instructions for the run. This
          #   is useful for modifying the behavior on a per-run basis without overriding other
          #   instructions.
          sig { returns(T.nilable(String)) }
          def additional_instructions
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def additional_instructions=(_)
          end

          # Adds additional messages to the thread before creating the run.
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage])) }
          def additional_messages
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]))
          end
          def additional_messages=(_)
          end

          # Overrides the
          #   [instructions](https://platform.openai.com/docs/api-reference/assistants/createAssistant)
          #   of the assistant. This is useful for modifying the behavior on a per-run basis.
          sig { returns(T.nilable(String)) }
          def instructions
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def instructions=(_)
          end

          # The maximum number of completion tokens that may be used over the course of the
          #   run. The run will make a best effort to use only the number of completion tokens
          #   specified, across multiple turns of the run. If the run exceeds the number of
          #   completion tokens specified, the run will end with status `incomplete`. See
          #   `incomplete_details` for more info.
          sig { returns(T.nilable(Integer)) }
          def max_completion_tokens
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def max_completion_tokens=(_)
          end

          # The maximum number of prompt tokens that may be used over the course of the run.
          #   The run will make a best effort to use only the number of prompt tokens
          #   specified, across multiple turns of the run. If the run exceeds the number of
          #   prompt tokens specified, the run will end with status `incomplete`. See
          #   `incomplete_details` for more info.
          sig { returns(T.nilable(Integer)) }
          def max_prompt_tokens
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def max_prompt_tokens=(_)
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

          # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
          #   be used to execute this run. If a value is provided here, it will override the
          #   model associated with the assistant. If not, the model associated with the
          #   assistant will be used.
          sig { returns(T.nilable(T.any(String, Symbol))) }
          def model
          end

          sig { params(_: T.nilable(T.any(String, Symbol))).returns(T.nilable(T.any(String, Symbol))) }
          def model=(_)
          end

          # Whether to enable
          #   [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          #   during tool use.
          sig { returns(T.nilable(T::Boolean)) }
          def parallel_tool_calls
          end

          sig { params(_: T::Boolean).returns(T::Boolean) }
          def parallel_tool_calls=(_)
          end

          # **o1 and o3-mini models only**
          #
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #   result in faster responses and fewer tokens used on reasoning in a response.
          sig { returns(T.nilable(Symbol)) }
          def reasoning_effort
          end

          sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
          def reasoning_effort=(_)
          end

          # Specifies the format that the model must output. Compatible with
          #   [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          #   [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          #   and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          #   Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          #   Outputs which ensures the model will match your supplied JSON schema. Learn more
          #   in the
          #   [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          #   Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          #   message the model generates is valid JSON.
          #
          #   **Important:** when using JSON mode, you **must** also instruct the model to
          #   produce JSON yourself via a system or user message. Without this, the model may
          #   generate an unending stream of whitespace until the generation reaches the token
          #   limit, resulting in a long-running and seemingly "stuck" request. Also note that
          #   the message content may be partially cut off if `finish_reason="length"`, which
          #   indicates the generation exceeded `max_tokens` or the conversation exceeded the
          #   max context length.
          sig do
            returns(
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              )
            )
          end
          def response_format
          end

          sig do
            params(
              _: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              )
            )
              .returns(
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                )
              )
          end
          def response_format=(_)
          end

          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          #   make the output more random, while lower values like 0.2 will make it more
          #   focused and deterministic.
          sig { returns(T.nilable(Float)) }
          def temperature
          end

          sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
          def temperature=(_)
          end

          # Controls which (if any) tool is called by the model. `none` means the model will
          #   not call any tools and instead generates a message. `auto` is the default value
          #   and means the model can pick between generating a message or calling one or more
          #   tools. `required` means the model must call one or more tools before responding
          #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
          #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          #   call that tool.
          sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice))) }
          def tool_choice
          end

          sig do
            params(_: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
              .returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
          end
          def tool_choice=(_)
          end

          # Override the tools the assistant can use for this run. This is useful for
          #   modifying the behavior on a per-run basis.
          sig do
            returns(
              T.nilable(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ]
              )
            )
          end
          def tools
          end

          sig do
            params(
              _: T.nilable(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ]
              )
            )
              .returns(
                T.nilable(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::FileSearchTool,
                    OpenAI::Models::Beta::FunctionTool
                  )
                  ]
                )
              )
          end
          def tools=(_)
          end

          # An alternative to sampling with temperature, called nucleus sampling, where the
          #   model considers the results of the tokens with top_p probability mass. So 0.1
          #   means only the tokens comprising the top 10% probability mass are considered.
          #
          #   We generally recommend altering this or temperature but not both.
          sig { returns(T.nilable(Float)) }
          def top_p
          end

          sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
          def top_p=(_)
          end

          # Controls for how a thread will be truncated prior to the run. Use this to
          #   control the intial context window of the run.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy)) }
          def truncation_strategy
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy))
          end
          def truncation_strategy=(_)
          end

          sig do
            params(
              assistant_id: String,
              include: T::Array[Symbol],
              additional_instructions: T.nilable(String),
              additional_messages: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]),
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(OpenAI::Models::Metadata),
              model: T.nilable(T.any(String, Symbol)),
              parallel_tool_calls: T::Boolean,
              reasoning_effort: T.nilable(Symbol),
              response_format: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              ),
              temperature: T.nilable(Float),
              tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
              tools: T.nilable(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ]
              ),
              top_p: T.nilable(Float),
              truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy),
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
            )
              .returns(T.attached_class)
          end
          def self.new(
            assistant_id:,
            include: nil,
            additional_instructions: nil,
            additional_messages: nil,
            instructions: nil,
            max_completion_tokens: nil,
            max_prompt_tokens: nil,
            metadata: nil,
            model: nil,
            parallel_tool_calls: nil,
            reasoning_effort: nil,
            response_format: nil,
            temperature: nil,
            tool_choice: nil,
            tools: nil,
            top_p: nil,
            truncation_strategy: nil,
            request_options: {}
          )
          end

          sig do
            override
              .returns(
                {
                  assistant_id: String,
                  include: T::Array[Symbol],
                  additional_instructions: T.nilable(String),
                  additional_messages: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]),
                  instructions: T.nilable(String),
                  max_completion_tokens: T.nilable(Integer),
                  max_prompt_tokens: T.nilable(Integer),
                  metadata: T.nilable(OpenAI::Models::Metadata),
                  model: T.nilable(T.any(String, Symbol)),
                  parallel_tool_calls: T::Boolean,
                  reasoning_effort: T.nilable(Symbol),
                  response_format: T.nilable(
                    T.any(
                      Symbol,
                      OpenAI::Models::ResponseFormatText,
                      OpenAI::Models::ResponseFormatJSONObject,
                      OpenAI::Models::ResponseFormatJSONSchema
                    )
                  ),
                  temperature: T.nilable(Float),
                  tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
                  tools: T.nilable(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::FileSearchTool,
                      OpenAI::Models::Beta::FunctionTool
                    )
                    ]
                  ),
                  top_p: T.nilable(Float),
                  truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy),
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end

          class AdditionalMessage < OpenAI::BaseModel
            # The text contents of the message.
            sig do
              returns(
                T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                )
              )
            end
            def content
            end

            sig do
              params(
                _: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                )
              )
                .returns(
                  T.any(
                    String,
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                      OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                      OpenAI::Models::Beta::Threads::TextContentBlockParam
                    )
                    ]
                  )
                )
            end
            def content=(_)
            end

            # The role of the entity that is creating the message. Allowed values include:
            #
            #   - `user`: Indicates the message is sent by an actual user and should be used in
            #     most cases to represent user-generated messages.
            #   - `assistant`: Indicates the message is generated by the assistant. Use this
            #     value to insert messages from the assistant into the conversation.
            sig { returns(Symbol) }
            def role
            end

            sig { params(_: Symbol).returns(Symbol) }
            def role=(_)
            end

            # A list of files attached to the message, and the tools they should be added to.
            sig do
              returns(
                T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment])
              )
            end
            def attachments
            end

            sig do
              params(
                _: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment])
              )
                .returns(
                  T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment])
                )
            end
            def attachments=(_)
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

            sig do
              params(
                content: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                ),
                role: Symbol,
                attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment]),
                metadata: T.nilable(OpenAI::Models::Metadata)
              )
                .returns(T.attached_class)
            end
            def self.new(content:, role:, attachments: nil, metadata: nil)
            end

            sig do
              override
                .returns(
                  {
                    content: T.any(
                      String,
                      T::Array[
                      T.any(
                        OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                        OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                        OpenAI::Models::Beta::Threads::TextContentBlockParam
                      )
                      ]
                    ),
                    role: Symbol,
                    attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment]),
                    metadata: T.nilable(OpenAI::Models::Metadata)
                  }
                )
            end
            def to_hash
            end

            # The text contents of the message.
            class Content < OpenAI::Union
              abstract!

              MessageContentPartParamArray = T.type_alias do
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              end

              class << self
                sig do
                  override
                    .returns(
                      [
                        String,
                        T::Array[
                                              T.any(
                                                OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                                                OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                                                OpenAI::Models::Beta::Threads::TextContentBlockParam
                                              )
                                              ]
                      ]
                    )
                end
                def variants
                end
              end
            end

            # The role of the entity that is creating the message. Allowed values include:
            #
            #   - `user`: Indicates the message is sent by an actual user and should be used in
            #     most cases to represent user-generated messages.
            #   - `assistant`: Indicates the message is generated by the assistant. Use this
            #     value to insert messages from the assistant into the conversation.
            class Role < OpenAI::Enum
              abstract!

              USER = :user
              ASSISTANT = :assistant

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end

            class Attachment < OpenAI::BaseModel
              # The ID of the file to attach to the message.
              sig { returns(T.nilable(String)) }
              def file_id
              end

              sig { params(_: String).returns(String) }
              def file_id=(_)
              end

              # The tools to add this file to.
              sig do
                returns(
                  T.nilable(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
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
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
                  )
                  ]
                )
                  .returns(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
                    )
                    ]
                  )
              end
              def tools=(_)
              end

              sig do
                params(
                  file_id: String,
                  tools: T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
                  )
                  ]
                )
                  .returns(T.attached_class)
              end
              def self.new(file_id: nil, tools: nil)
              end

              sig do
                override
                  .returns(
                    {
                      file_id: String,
                      tools: T::Array[
                      T.any(
                        OpenAI::Models::Beta::CodeInterpreterTool,
                        OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
                      )
                      ]
                    }
                  )
              end
              def to_hash
              end

              class Tool < OpenAI::Union
                abstract!

                class FileSearch < OpenAI::BaseModel
                  # The type of tool being defined: `file_search`
                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig { params(type: Symbol).returns(T.attached_class) }
                  def self.new(type: :file_search)
                  end

                  sig { override.returns({type: Symbol}) }
                  def to_hash
                  end
                end

                class << self
                  sig do
                    override
                      .returns(
                        [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch]
                      )
                  end
                  def variants
                  end
                end
              end
            end
          end

          # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
          #   be used to execute this run. If a value is provided here, it will override the
          #   model associated with the assistant. If not, the model associated with the
          #   assistant will be used.
          class Model < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([String, Symbol]) }
              def variants
              end
            end
          end

          # **o1 and o3-mini models only**
          #
          #   Constrains effort on reasoning for
          #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
          #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
          #   result in faster responses and fewer tokens used on reasoning in a response.
          class ReasoningEffort < OpenAI::Enum
            abstract!

            LOW = T.let(:low, T.nilable(Symbol))
            MEDIUM = T.let(:medium, T.nilable(Symbol))
            HIGH = T.let(:high, T.nilable(Symbol))

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          class TruncationStrategy < OpenAI::BaseModel
            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The number of most recent messages from the thread when constructing the context
            #   for the run.
            sig { returns(T.nilable(Integer)) }
            def last_messages
            end

            sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def last_messages=(_)
            end

            # Controls for how a thread will be truncated prior to the run. Use this to
            #   control the intial context window of the run.
            sig { params(type: Symbol, last_messages: T.nilable(Integer)).returns(T.attached_class) }
            def self.new(type:, last_messages: nil)
            end

            sig { override.returns({type: Symbol, last_messages: T.nilable(Integer)}) }
            def to_hash
            end

            # The truncation strategy to use for the thread. The default is `auto`. If set to
            #   `last_messages`, the thread will be truncated to the n most recent messages in
            #   the thread. When set to `auto`, messages in the middle of the thread will be
            #   dropped to fit the context length of the model, `max_prompt_tokens`.
            class Type < OpenAI::Enum
              abstract!

              AUTO = :auto
              LAST_MESSAGES = :last_messages

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
  end
end
