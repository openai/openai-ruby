# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadCreateAndRunParams < OpenAI::BaseModel
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

        # Override the default system message of the assistant. This is useful for
        #   modifying the behavior on a per-run basis.
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
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata
        end

        sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata=(_)
        end

        # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #   be used to execute this run. If a value is provided here, it will override the
        #   model associated with the assistant. If not, the model associated with the
        #   assistant will be used.
        sig { returns(T.nilable(T.any(String, OpenAI::Models::ChatModel::OrSymbol))) }
        def model
        end

        sig do
          params(_: T.nilable(T.any(String, OpenAI::Models::ChatModel::OrSymbol)))
            .returns(T.nilable(T.any(String, OpenAI::Models::ChatModel::OrSymbol)))
        end
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

        # Options to create a new thread. If no thread is provided when running a request,
        #   an empty thread will be created.
        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread)) }
        def thread
        end

        sig do
          params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread)
            .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread)
        end
        def thread=(_)
        end

        # Controls which (if any) tool is called by the model. `none` means the model will
        #   not call any tools and instead generates a message. `auto` is the default value
        #   and means the model can pick between generating a message or calling one or more
        #   tools. `required` means the model must call one or more tools before responding
        #   to the user. Specifying a particular tool like `{"type": "file_search"}` or
        #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        #   call that tool.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                OpenAI::Models::Beta::AssistantToolChoice
              )
            )
          )
        end
        def tool_choice
        end

        sig do
          params(
            _: T.nilable(
              T.any(
                OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                OpenAI::Models::Beta::AssistantToolChoice
              )
            )
          )
            .returns(
              T.nilable(
                T.any(
                  OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                  OpenAI::Models::Beta::AssistantToolChoice
                )
              )
            )
        end
        def tool_choice=(_)
        end

        # A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources))
        end
        def tool_resources=(_)
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
        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy)) }
        def truncation_strategy
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy))
            .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy))
        end
        def truncation_strategy=(_)
        end

        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.nilable(T.any(String, OpenAI::Models::ChatModel::OrSymbol)),
            parallel_tool_calls: T::Boolean,
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            thread: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread,
            tool_choice: T.nilable(
              T.any(
                OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                OpenAI::Models::Beta::AssistantToolChoice
              )
            ),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources),
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
            truncation_strategy: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          assistant_id:,
          instructions: nil,
          max_completion_tokens: nil,
          max_prompt_tokens: nil,
          metadata: nil,
          model: nil,
          parallel_tool_calls: nil,
          response_format: nil,
          temperature: nil,
          thread: nil,
          tool_choice: nil,
          tool_resources: nil,
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
                instructions: T.nilable(String),
                max_completion_tokens: T.nilable(Integer),
                max_prompt_tokens: T.nilable(Integer),
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: T.nilable(T.any(String, OpenAI::Models::ChatModel::OrSymbol)),
                parallel_tool_calls: T::Boolean,
                response_format: T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                ),
                temperature: T.nilable(Float),
                thread: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread,
                tool_choice: T.nilable(
                  T.any(
                    OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                    OpenAI::Models::Beta::AssistantToolChoice
                  )
                ),
                tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources),
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
                truncation_strategy: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        #   be used to execute this run. If a value is provided here, it will override the
        #   model associated with the assistant. If not, the model associated with the
        #   assistant will be used.
        module Model
          extend OpenAI::Union

          Variants = type_template(:out) { {fixed: T.any(String, OpenAI::Models::ChatModel::OrSymbol)} }
        end

        class Thread < OpenAI::BaseModel
          # A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
          #   start the thread with.
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message])) }
          def messages
          end

          sig do
            params(_: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message])
              .returns(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message])
          end
          def messages=(_)
          end

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          def metadata
          end

          sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
          def metadata=(_)
          end

          # A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources)) }
          def tool_resources
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources))
              .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources))
          end
          def tool_resources=(_)
          end

          # Options to create a new thread. If no thread is provided when running a request,
          #   an empty thread will be created.
          sig do
            params(
              messages: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message],
              metadata: T.nilable(T::Hash[Symbol, String]),
              tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources)
            )
              .returns(T.attached_class)
          end
          def self.new(messages: nil, metadata: nil, tool_resources: nil)
          end

          sig do
            override
              .returns(
                {
                  messages: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message],
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources)
                }
              )
          end
          def to_hash
          end

          class Message < OpenAI::BaseModel
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
            sig { returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol) }
            def role
            end

            sig do
              params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol)
                .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol)
            end
            def role=(_)
            end

            # A list of files attached to the message, and the tools they should be added to.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment])) }
            def attachments
            end

            sig do
              params(
                _: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment])
              )
                .returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment]))
            end
            def attachments=(_)
            end

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            #   for storing additional information about the object in a structured format, and
            #   querying for objects via API or the dashboard.
            #
            #   Keys are strings with a maximum length of 64 characters. Values are strings with
            #   a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            def metadata
            end

            sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
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
                role: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol,
                attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment]),
                metadata: T.nilable(T::Hash[Symbol, String])
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
                    role: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol,
                    attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment]),
                    metadata: T.nilable(T::Hash[Symbol, String])
                  }
                )
            end
            def to_hash
            end

            # The text contents of the message.
            module Content
              extend OpenAI::Union

              Variants =
                type_template(:out) do
                  {
                    fixed: T.any(
                      String,
                      T::Array[
                      T.any(
                        OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                        OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                        OpenAI::Models::Beta::Threads::TextContentBlockParam
                      )
                      ]
                    )
                  }
                end

              MessageContentPartParamArray =
                T.let(OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContentPartParam], OpenAI::Converter)
            end

            # The role of the entity that is creating the message. Allowed values include:
            #
            #   - `user`: Indicates the message is sent by an actual user and should be used in
            #     most cases to represent user-generated messages.
            #   - `assistant`: Indicates the message is generated by the assistant. Use this
            #     value to insert messages from the assistant into the conversation.
            module Role
              extend OpenAI::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::TaggedSymbol) }

              USER = T.let(:user, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol)
              ASSISTANT =
                T.let(:assistant, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol)
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
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
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
                    OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                  )
                  ]
                )
                  .returns(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
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
                    OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
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
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                      )
                      ]
                    }
                  )
              end
              def to_hash
              end

              module Tool
                extend OpenAI::Union

                Variants =
                  type_template(:out) do
                    {
                      fixed: T.any(
                        OpenAI::Models::Beta::CodeInterpreterTool,
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                      )
                    }
                  end

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
              end
            end
          end

          class ToolResources < OpenAI::BaseModel
            sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter)) }
            def code_interpreter
            end

            sig do
              params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter)
                .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter)
            end
            def code_interpreter=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch)) }
            def file_search
            end

            sig do
              params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch)
                .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch)
            end
            def file_search=(_)
            end

            # A set of resources that are made available to the assistant's tools in this
            #   thread. The resources are specific to the type of tool. For example, the
            #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
            #   tool requires a list of vector store IDs.
            sig do
              params(
                code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter,
                file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch
              )
                .returns(T.attached_class)
            end
            def self.new(code_interpreter: nil, file_search: nil)
            end

            sig do
              override
                .returns(
                  {
                    code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter,
                    file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch
                  }
                )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::BaseModel
              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
              #   available to the `code_interpreter` tool. There can be a maximum of 20 files
              #   associated with the tool.
              sig { returns(T.nilable(T::Array[String])) }
              def file_ids
              end

              sig { params(_: T::Array[String]).returns(T::Array[String]) }
              def file_ids=(_)
              end

              sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
              def self.new(file_ids: nil)
              end

              sig { override.returns({file_ids: T::Array[String]}) }
              def to_hash
              end
            end

            class FileSearch < OpenAI::BaseModel
              # The
              #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              #   attached to this thread. There can be a maximum of 1 vector store attached to
              #   the thread.
              sig { returns(T.nilable(T::Array[String])) }
              def vector_store_ids
              end

              sig { params(_: T::Array[String]).returns(T::Array[String]) }
              def vector_store_ids=(_)
              end

              # A helper to create a
              #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              #   with file_ids and attach it to this thread. There can be a maximum of 1 vector
              #   store attached to the thread.
              sig do
                returns(
                  T.nilable(
                    T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                  )
                )
              end
              def vector_stores
              end

              sig do
                params(
                  _: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                )
                  .returns(
                    T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                  )
              end
              def vector_stores=(_)
              end

              sig do
                params(
                  vector_store_ids: T::Array[String],
                  vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                )
                  .returns(T.attached_class)
              end
              def self.new(vector_store_ids: nil, vector_stores: nil)
              end

              sig do
                override
                  .returns(
                    {
                      vector_store_ids: T::Array[String],
                      vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                    }
                  )
              end
              def to_hash
              end

              class VectorStore < OpenAI::BaseModel
                # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                #   strategy.
                sig do
                  returns(
                    T.nilable(
                      T.any(
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      )
                    )
                  )
                end
                def chunking_strategy
                end

                sig do
                  params(
                    _: T.any(
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  )
                    .returns(
                      T.any(
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      )
                    )
                end
                def chunking_strategy=(_)
                end

                # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
                #   add to the vector store. There can be a maximum of 10000 files in a vector
                #   store.
                sig { returns(T.nilable(T::Array[String])) }
                def file_ids
                end

                sig { params(_: T::Array[String]).returns(T::Array[String]) }
                def file_ids=(_)
                end

                # Set of 16 key-value pairs that can be attached to an object. This can be useful
                #   for storing additional information about the object in a structured format, and
                #   querying for objects via API or the dashboard.
                #
                #   Keys are strings with a maximum length of 64 characters. Values are strings with
                #   a maximum length of 512 characters.
                sig { returns(T.nilable(T::Hash[Symbol, String])) }
                def metadata
                end

                sig do
                  params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String]))
                end
                def metadata=(_)
                end

                sig do
                  params(
                    chunking_strategy: T.any(
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    ),
                    file_ids: T::Array[String],
                    metadata: T.nilable(T::Hash[Symbol, String])
                  )
                    .returns(T.attached_class)
                end
                def self.new(chunking_strategy: nil, file_ids: nil, metadata: nil)
                end

                sig do
                  override
                    .returns(
                      {
                        chunking_strategy: T.any(
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                        ),
                        file_ids: T::Array[String],
                        metadata: T.nilable(T::Hash[Symbol, String])
                      }
                    )
                end
                def to_hash
                end

                # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                #   strategy.
                class ChunkingStrategy < OpenAI::Union
                  abstract!

                  Variants =
                    type_template(:out) do
                      {
                        fixed: T.any(
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                        )
                      }
                    end

                  class Auto < OpenAI::BaseModel
                    # Always `auto`.
                    sig { returns(Symbol) }
                    def type
                    end

                    sig { params(_: Symbol).returns(Symbol) }
                    def type=(_)
                    end

                    # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                    #   `800` and `chunk_overlap_tokens` of `400`.
                    sig { params(type: Symbol).returns(T.attached_class) }
                    def self.new(type: :auto)
                    end

                    sig { override.returns({type: Symbol}) }
                    def to_hash
                    end
                  end

                  class Static < OpenAI::BaseModel
                    sig do
                      returns(
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                      )
                    end
                    def static
                    end

                    sig do
                      params(
                        _: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                      )
                        .returns(
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                        )
                    end
                    def static=(_)
                    end

                    # Always `static`.
                    sig { returns(Symbol) }
                    def type
                    end

                    sig { params(_: Symbol).returns(Symbol) }
                    def type=(_)
                    end

                    sig do
                      params(
                        static: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                        type: Symbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(static:, type: :static)
                    end

                    sig do
                      override
                        .returns(
                          {
                            static: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                            type: Symbol
                          }
                        )
                    end
                    def to_hash
                    end

                    class Static < OpenAI::BaseModel
                      # The number of tokens that overlap between chunks. The default value is `400`.
                      #
                      #   Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                      sig { returns(Integer) }
                      def chunk_overlap_tokens
                      end

                      sig { params(_: Integer).returns(Integer) }
                      def chunk_overlap_tokens=(_)
                      end

                      # The maximum number of tokens in each chunk. The default value is `800`. The
                      #   minimum value is `100` and the maximum value is `4096`.
                      sig { returns(Integer) }
                      def max_chunk_size_tokens
                      end

                      sig { params(_: Integer).returns(Integer) }
                      def max_chunk_size_tokens=(_)
                      end

                      sig do
                        params(
                          chunk_overlap_tokens: Integer,
                          max_chunk_size_tokens: Integer
                        ).returns(T.attached_class)
                      end
                      def self.new(chunk_overlap_tokens:, max_chunk_size_tokens:)
                      end

                      sig do
                        override.returns({chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer})
                      end
                      def to_hash
                      end
                    end
                  end
                end
              end
            end
          end
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          # A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch
                }
              )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::BaseModel
            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
            sig { returns(T.nilable(T::Array[String])) }
            def file_ids
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def file_ids=(_)
            end

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(file_ids: nil)
            end

            sig { override.returns({file_ids: T::Array[String]}) }
            def to_hash
            end
          end

          class FileSearch < OpenAI::BaseModel
            # The ID of the
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this assistant. There can be a maximum of 1 vector store attached to
            #   the assistant.
            sig { returns(T.nilable(T::Array[String])) }
            def vector_store_ids
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def vector_store_ids=(_)
            end

            sig { params(vector_store_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(vector_store_ids: nil)
            end

            sig { override.returns({vector_store_ids: T::Array[String]}) }
            def to_hash
            end
          end
        end

        module Tool
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
              }
            end
        end

        class TruncationStrategy < OpenAI::BaseModel
          # The truncation strategy to use for the thread. The default is `auto`. If set to
          #   `last_messages`, the thread will be truncated to the n most recent messages in
          #   the thread. When set to `auto`, messages in the middle of the thread will be
          #   dropped to fit the context length of the model, `max_prompt_tokens`.
          sig { returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol) }
          def type
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol)
              .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol)
          end
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
          sig do
            params(
              type: OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol,
              last_messages: T.nilable(Integer)
            )
              .returns(T.attached_class)
          end
          def self.new(type:, last_messages: nil)
          end

          sig do
            override
              .returns(
                {
                  type: OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol,
                  last_messages: T.nilable(Integer)
                }
              )
          end
          def to_hash
          end

          # The truncation strategy to use for the thread. The default is `auto`. If set to
          #   `last_messages`, the thread will be truncated to the n most recent messages in
          #   the thread. When set to `auto`, messages in the middle of the thread will be
          #   dropped to fit the context length of the model, `max_prompt_tokens`.
          module Type
            extend OpenAI::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::TaggedSymbol) }

            AUTO = T.let(:auto, OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol)
            LAST_MESSAGES =
              T.let(:last_messages, OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol)
          end
        end
      end
    end
  end
end
