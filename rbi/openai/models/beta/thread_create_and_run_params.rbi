# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadCreateAndRunParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::ThreadCreateAndRunParams,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the
        # [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
        # execute this run.
        sig { returns(String) }
        attr_accessor :assistant_id

        # Override the default system message of the assistant. This is useful for
        # modifying the behavior on a per-run basis.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # The maximum number of completion tokens that may be used over the course of the
        # run. The run will make a best effort to use only the number of completion tokens
        # specified, across multiple turns of the run. If the run exceeds the number of
        # completion tokens specified, the run will end with status `incomplete`. See
        # `incomplete_details` for more info.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_completion_tokens

        # The maximum number of prompt tokens that may be used over the course of the run.
        # The run will make a best effort to use only the number of prompt tokens
        # specified, across multiple turns of the run. If the run exceeds the number of
        # prompt tokens specified, the run will end with status `incomplete`. See
        # `incomplete_details` for more info.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :max_prompt_tokens

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        # be used to execute this run. If a value is provided here, it will override the
        # model associated with the assistant. If not, the model associated with the
        # assistant will be used.
        sig { returns(T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol))) }
        attr_accessor :model

        # Whether to enable
        # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
        # during tool use.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :parallel_tool_calls

        sig { params(parallel_tool_calls: T::Boolean).void }
        attr_writer :parallel_tool_calls

        # Specifies the format that the model must output. Compatible with
        # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
        # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
        # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
        #
        # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
        # Outputs which ensures the model will match your supplied JSON schema. Learn more
        # in the
        # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
        #
        # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
        # message the model generates is valid JSON.
        #
        # **Important:** when using JSON mode, you **must** also instruct the model to
        # produce JSON yourself via a system or user message. Without this, the model may
        # generate an unending stream of whitespace until the generation reaches the token
        # limit, resulting in a long-running and seemingly "stuck" request. Also note that
        # the message content may be partially cut off if `finish_reason="length"`, which
        # indicates the generation exceeded `max_tokens` or the conversation exceeded the
        # max context length.
        sig do
          returns(
            T.nilable(
              T.any(
                Symbol,
                OpenAI::ResponseFormatText,
                OpenAI::ResponseFormatJSONObject,
                OpenAI::ResponseFormatJSONSchema
              )
            )
          )
        end
        attr_accessor :response_format

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # Options to create a new thread. If no thread is provided when running a request,
        # an empty thread will be created.
        sig do
          returns(T.nilable(OpenAI::Beta::ThreadCreateAndRunParams::Thread))
        end
        attr_reader :thread

        sig do
          params(
            thread: OpenAI::Beta::ThreadCreateAndRunParams::Thread::OrHash
          ).void
        end
        attr_writer :thread

        # Controls which (if any) tool is called by the model. `none` means the model will
        # not call any tools and instead generates a message. `auto` is the default value
        # and means the model can pick between generating a message or calling one or more
        # tools. `required` means the model must call one or more tools before responding
        # to the user. Specifying a particular tool like `{"type": "file_search"}` or
        # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
        # call that tool.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                OpenAI::Beta::AssistantToolChoice
              )
            )
          )
        end
        attr_accessor :tool_choice

        # A set of resources that are used by the assistant's tools. The resources are
        # specific to the type of tool. For example, the `code_interpreter` tool requires
        # a list of file IDs, while the `file_search` tool requires a list of vector store
        # IDs.
        sig do
          returns(
            T.nilable(OpenAI::Beta::ThreadCreateAndRunParams::ToolResources)
          )
        end
        attr_reader :tool_resources

        sig do
          params(
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::OrHash
              )
          ).void
        end
        attr_writer :tool_resources

        # Override the tools the assistant can use for this run. This is useful for
        # modifying the behavior on a per-run basis.
        sig do
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Beta::CodeInterpreterTool,
                  OpenAI::Beta::FileSearchTool,
                  OpenAI::Beta::FunctionTool
                )
              ]
            )
          )
        end
        attr_accessor :tools

        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or temperature but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

        # Controls for how a thread will be truncated prior to the run. Use this to
        # control the intial context window of the run.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy
            )
          )
        end
        attr_reader :truncation_strategy

        sig do
          params(
            truncation_strategy:
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::OrHash
              )
          ).void
        end
        attr_writer :truncation_strategy

        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol)),
            parallel_tool_calls: T::Boolean,
            response_format:
              T.nilable(
                T.any(
                  Symbol,
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash,
                  OpenAI::ResponseFormatJSONSchema::OrHash
                )
              ),
            temperature: T.nilable(Float),
            thread: OpenAI::Beta::ThreadCreateAndRunParams::Thread::OrHash,
            tool_choice:
              T.nilable(
                T.any(
                  OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                  OpenAI::Beta::AssistantToolChoice::OrHash
                )
              ),
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::OrHash
              ),
            tools:
              T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Beta::CodeInterpreterTool::OrHash,
                    OpenAI::Beta::FileSearchTool::OrHash,
                    OpenAI::Beta::FunctionTool::OrHash
                  )
                ]
              ),
            top_p: T.nilable(Float),
            truncation_strategy:
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the
          # [assistant](https://platform.openai.com/docs/api-reference/assistants) to use to
          # execute this run.
          assistant_id:,
          # Override the default system message of the assistant. This is useful for
          # modifying the behavior on a per-run basis.
          instructions: nil,
          # The maximum number of completion tokens that may be used over the course of the
          # run. The run will make a best effort to use only the number of completion tokens
          # specified, across multiple turns of the run. If the run exceeds the number of
          # completion tokens specified, the run will end with status `incomplete`. See
          # `incomplete_details` for more info.
          max_completion_tokens: nil,
          # The maximum number of prompt tokens that may be used over the course of the run.
          # The run will make a best effort to use only the number of prompt tokens
          # specified, across multiple turns of the run. If the run exceeds the number of
          # prompt tokens specified, the run will end with status `incomplete`. See
          # `incomplete_details` for more info.
          max_prompt_tokens: nil,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
          # be used to execute this run. If a value is provided here, it will override the
          # model associated with the assistant. If not, the model associated with the
          # assistant will be used.
          model: nil,
          # Whether to enable
          # [parallel function calling](https://platform.openai.com/docs/guides/function-calling#configuring-parallel-function-calling)
          # during tool use.
          parallel_tool_calls: nil,
          # Specifies the format that the model must output. Compatible with
          # [GPT-4o](https://platform.openai.com/docs/models#gpt-4o),
          # [GPT-4 Turbo](https://platform.openai.com/docs/models#gpt-4-turbo-and-gpt-4),
          # and all GPT-3.5 Turbo models since `gpt-3.5-turbo-1106`.
          #
          # Setting to `{ "type": "json_schema", "json_schema": {...} }` enables Structured
          # Outputs which ensures the model will match your supplied JSON schema. Learn more
          # in the
          # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
          #
          # Setting to `{ "type": "json_object" }` enables JSON mode, which ensures the
          # message the model generates is valid JSON.
          #
          # **Important:** when using JSON mode, you **must** also instruct the model to
          # produce JSON yourself via a system or user message. Without this, the model may
          # generate an unending stream of whitespace until the generation reaches the token
          # limit, resulting in a long-running and seemingly "stuck" request. Also note that
          # the message content may be partially cut off if `finish_reason="length"`, which
          # indicates the generation exceeded `max_tokens` or the conversation exceeded the
          # max context length.
          response_format: nil,
          # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
          # make the output more random, while lower values like 0.2 will make it more
          # focused and deterministic.
          temperature: nil,
          # Options to create a new thread. If no thread is provided when running a request,
          # an empty thread will be created.
          thread: nil,
          # Controls which (if any) tool is called by the model. `none` means the model will
          # not call any tools and instead generates a message. `auto` is the default value
          # and means the model can pick between generating a message or calling one or more
          # tools. `required` means the model must call one or more tools before responding
          # to the user. Specifying a particular tool like `{"type": "file_search"}` or
          # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
          # call that tool.
          tool_choice: nil,
          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          tool_resources: nil,
          # Override the tools the assistant can use for this run. This is useful for
          # modifying the behavior on a per-run basis.
          tools: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or temperature but not both.
          top_p: nil,
          # Controls for how a thread will be truncated prior to the run. Use this to
          # control the intial context window of the run.
          truncation_strategy: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              assistant_id: String,
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: T.nilable(T.any(String, OpenAI::ChatModel::OrSymbol)),
              parallel_tool_calls: T::Boolean,
              response_format:
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::ResponseFormatText,
                    OpenAI::ResponseFormatJSONObject,
                    OpenAI::ResponseFormatJSONSchema
                  )
                ),
              temperature: T.nilable(Float),
              thread: OpenAI::Beta::ThreadCreateAndRunParams::Thread,
              tool_choice:
                T.nilable(
                  T.any(
                    OpenAI::Beta::AssistantToolChoiceOption::Auto::OrSymbol,
                    OpenAI::Beta::AssistantToolChoice
                  )
                ),
              tool_resources:
                T.nilable(
                  OpenAI::Beta::ThreadCreateAndRunParams::ToolResources
                ),
              tools:
                T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::CodeInterpreterTool,
                      OpenAI::Beta::FileSearchTool,
                      OpenAI::Beta::FunctionTool
                    )
                  ]
                ),
              top_p: T.nilable(Float),
              truncation_strategy:
                T.nilable(
                  OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy
                ),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # The ID of the [Model](https://platform.openai.com/docs/api-reference/models) to
        # be used to execute this run. If a value is provided here, it will override the
        # model associated with the assistant. If not, the model associated with the
        # assistant will be used.
        module Model
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias { T.any(String, OpenAI::ChatModel::TaggedSymbol) }

          sig do
            override.returns(
              T::Array[OpenAI::Beta::ThreadCreateAndRunParams::Model::Variants]
            )
          end
          def self.variants
          end
        end

        class Thread < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ThreadCreateAndRunParams::Thread,
                OpenAI::Internal::AnyHash
              )
            end

          # A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
          # start the thread with.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message
                ]
              )
            )
          end
          attr_reader :messages

          sig do
            params(
              messages:
                T::Array[
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::OrHash
                ]
            ).void
          end
          attr_writer :messages

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          # A set of resources that are made available to the assistant's tools in this
          # thread. The resources are specific to the type of tool. For example, the
          # `code_interpreter` tool requires a list of file IDs, while the `file_search`
          # tool requires a list of vector store IDs.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources
              )
            )
          end
          attr_reader :tool_resources

          sig do
            params(
              tool_resources:
                T.nilable(
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::OrHash
                )
            ).void
          end
          attr_writer :tool_resources

          # Options to create a new thread. If no thread is provided when running a request,
          # an empty thread will be created.
          sig do
            params(
              messages:
                T::Array[
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::OrHash
                ],
              metadata: T.nilable(T::Hash[Symbol, String]),
              tool_resources:
                T.nilable(
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::OrHash
                )
            ).returns(T.attached_class)
          end
          def self.new(
            # A list of [messages](https://platform.openai.com/docs/api-reference/messages) to
            # start the thread with.
            messages: nil,
            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata: nil,
            # A set of resources that are made available to the assistant's tools in this
            # thread. The resources are specific to the type of tool. For example, the
            # `code_interpreter` tool requires a list of file IDs, while the `file_search`
            # tool requires a list of vector store IDs.
            tool_resources: nil
          )
          end

          sig do
            override.returns(
              {
                messages:
                  T::Array[
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message
                  ],
                metadata: T.nilable(T::Hash[Symbol, String]),
                tool_resources:
                  T.nilable(
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources
                  )
              }
            )
          end
          def to_hash
          end

          class Message < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message,
                  OpenAI::Internal::AnyHash
                )
              end

            # The text contents of the message.
            sig do
              returns(
                OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Content::Variants
              )
            end
            attr_accessor :content

            # The role of the entity that is creating the message. Allowed values include:
            #
            # - `user`: Indicates the message is sent by an actual user and should be used in
            #   most cases to represent user-generated messages.
            # - `assistant`: Indicates the message is generated by the assistant. Use this
            #   value to insert messages from the assistant into the conversation.
            sig do
              returns(
                OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol
              )
            end
            attr_accessor :role

            # A list of files attached to the message, and the tools they should be added to.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment
                  ]
                )
              )
            end
            attr_accessor :attachments

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            sig do
              params(
                content:
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Content::Variants,
                role:
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol,
                attachments:
                  T.nilable(
                    T::Array[
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::OrHash
                    ]
                  ),
                metadata: T.nilable(T::Hash[Symbol, String])
              ).returns(T.attached_class)
            end
            def self.new(
              # The text contents of the message.
              content:,
              # The role of the entity that is creating the message. Allowed values include:
              #
              # - `user`: Indicates the message is sent by an actual user and should be used in
              #   most cases to represent user-generated messages.
              # - `assistant`: Indicates the message is generated by the assistant. Use this
              #   value to insert messages from the assistant into the conversation.
              role:,
              # A list of files attached to the message, and the tools they should be added to.
              attachments: nil,
              # Set of 16 key-value pairs that can be attached to an object. This can be useful
              # for storing additional information about the object in a structured format, and
              # querying for objects via API or the dashboard.
              #
              # Keys are strings with a maximum length of 64 characters. Values are strings with
              # a maximum length of 512 characters.
              metadata: nil
            )
            end

            sig do
              override.returns(
                {
                  content:
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Content::Variants,
                  role:
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role::OrSymbol,
                  attachments:
                    T.nilable(
                      T::Array[
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment
                      ]
                    ),
                  metadata: T.nilable(T::Hash[Symbol, String])
                }
              )
            end
            def to_hash
            end

            # The text contents of the message.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    T::Array[
                      OpenAI::Beta::Threads::MessageContentPartParam::Variants
                    ]
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Content::Variants
                  ]
                )
              end
              def self.variants
              end

              MessageContentPartParamArray =
                T.let(
                  OpenAI::Internal::Type::ArrayOf[
                    union: OpenAI::Beta::Threads::MessageContentPartParam
                  ],
                  OpenAI::Internal::Type::Converter
                )
            end

            # The role of the entity that is creating the message. Allowed values include:
            #
            # - `user`: Indicates the message is sent by an actual user and should be used in
            #   most cases to represent user-generated messages.
            # - `assistant`: Indicates the message is generated by the assistant. Use this
            #   value to insert messages from the assistant into the conversation.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USER =
                T.let(
                  :user,
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role::TaggedSymbol
                )
              ASSISTANT =
                T.let(
                  :assistant,
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Role::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            class Attachment < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the file to attach to the message.
              sig { returns(T.nilable(String)) }
              attr_reader :file_id

              sig { params(file_id: String).void }
              attr_writer :file_id

              # The tools to add this file to.
              sig do
                returns(
                  T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::CodeInterpreterTool,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
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
                        OpenAI::Beta::CodeInterpreterTool::OrHash,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch::OrHash
                      )
                    ]
                ).void
              end
              attr_writer :tools

              sig do
                params(
                  file_id: String,
                  tools:
                    T::Array[
                      T.any(
                        OpenAI::Beta::CodeInterpreterTool::OrHash,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch::OrHash
                      )
                    ]
                ).returns(T.attached_class)
              end
              def self.new(
                # The ID of the file to attach to the message.
                file_id: nil,
                # The tools to add this file to.
                tools: nil
              )
              end

              sig do
                override.returns(
                  {
                    file_id: String,
                    tools:
                      T::Array[
                        T.any(
                          OpenAI::Beta::CodeInterpreterTool,
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                        )
                      ]
                  }
                )
              end
              def to_hash
              end

              module Tool
                extend OpenAI::Internal::Type::Union

                Variants =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::CodeInterpreterTool,
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                    )
                  end

                class FileSearch < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  # The type of tool being defined: `file_search`
                  sig { returns(Symbol) }
                  attr_accessor :type

                  sig { params(type: Symbol).returns(T.attached_class) }
                  def self.new(
                    # The type of tool being defined: `file_search`
                    type: :file_search
                  )
                  end

                  sig { override.returns({ type: Symbol }) }
                  def to_hash
                  end
                end

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::Variants
                    ]
                  )
                end
                def self.variants
                end
              end
            end
          end

          class ToolResources < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter
                )
              )
            end
            attr_reader :code_interpreter

            sig do
              params(
                code_interpreter:
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter::OrHash
              ).void
            end
            attr_writer :code_interpreter

            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch
                )
              )
            end
            attr_reader :file_search

            sig do
              params(
                file_search:
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::OrHash
              ).void
            end
            attr_writer :file_search

            # A set of resources that are made available to the assistant's tools in this
            # thread. The resources are specific to the type of tool. For example, the
            # `code_interpreter` tool requires a list of file IDs, while the `file_search`
            # tool requires a list of vector store IDs.
            sig do
              params(
                code_interpreter:
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter::OrHash,
                file_search:
                  OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::OrHash
              ).returns(T.attached_class)
            end
            def self.new(code_interpreter: nil, file_search: nil)
            end

            sig do
              override.returns(
                {
                  code_interpreter:
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter,
                  file_search:
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
              # available to the `code_interpreter` tool. There can be a maximum of 20 files
              # associated with the tool.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :file_ids

              sig { params(file_ids: T::Array[String]).void }
              attr_writer :file_ids

              sig do
                params(file_ids: T::Array[String]).returns(T.attached_class)
              end
              def self.new(
                # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
                # available to the `code_interpreter` tool. There can be a maximum of 20 files
                # associated with the tool.
                file_ids: nil
              )
              end

              sig { override.returns({ file_ids: T::Array[String] }) }
              def to_hash
              end
            end

            class FileSearch < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The
              # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              # attached to this thread. There can be a maximum of 1 vector store attached to
              # the thread.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :vector_store_ids

              sig { params(vector_store_ids: T::Array[String]).void }
              attr_writer :vector_store_ids

              # A helper to create a
              # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              # with file_ids and attach it to this thread. There can be a maximum of 1 vector
              # store attached to the thread.
              sig do
                returns(
                  T.nilable(
                    T::Array[
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore
                    ]
                  )
                )
              end
              attr_reader :vector_stores

              sig do
                params(
                  vector_stores:
                    T::Array[
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::OrHash
                    ]
                ).void
              end
              attr_writer :vector_stores

              sig do
                params(
                  vector_store_ids: T::Array[String],
                  vector_stores:
                    T::Array[
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::OrHash
                    ]
                ).returns(T.attached_class)
              end
              def self.new(
                # The
                # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
                # attached to this thread. There can be a maximum of 1 vector store attached to
                # the thread.
                vector_store_ids: nil,
                # A helper to create a
                # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
                # with file_ids and attach it to this thread. There can be a maximum of 1 vector
                # store attached to the thread.
                vector_stores: nil
              )
              end

              sig do
                override.returns(
                  {
                    vector_store_ids: T::Array[String],
                    vector_stores:
                      T::Array[
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore
                      ]
                  }
                )
              end
              def to_hash
              end

              class VectorStore < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                # strategy.
                sig do
                  returns(
                    T.nilable(
                      T.any(
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      )
                    )
                  )
                end
                attr_reader :chunking_strategy

                sig do
                  params(
                    chunking_strategy:
                      T.any(
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto::OrHash,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::OrHash
                      )
                  ).void
                end
                attr_writer :chunking_strategy

                # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
                # add to the vector store. There can be a maximum of 10000 files in a vector
                # store.
                sig { returns(T.nilable(T::Array[String])) }
                attr_reader :file_ids

                sig { params(file_ids: T::Array[String]).void }
                attr_writer :file_ids

                # Set of 16 key-value pairs that can be attached to an object. This can be useful
                # for storing additional information about the object in a structured format, and
                # querying for objects via API or the dashboard.
                #
                # Keys are strings with a maximum length of 64 characters. Values are strings with
                # a maximum length of 512 characters.
                sig { returns(T.nilable(T::Hash[Symbol, String])) }
                attr_accessor :metadata

                sig do
                  params(
                    chunking_strategy:
                      T.any(
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto::OrHash,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::OrHash
                      ),
                    file_ids: T::Array[String],
                    metadata: T.nilable(T::Hash[Symbol, String])
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                  # strategy.
                  chunking_strategy: nil,
                  # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs to
                  # add to the vector store. There can be a maximum of 10000 files in a vector
                  # store.
                  file_ids: nil,
                  # Set of 16 key-value pairs that can be attached to an object. This can be useful
                  # for storing additional information about the object in a structured format, and
                  # querying for objects via API or the dashboard.
                  #
                  # Keys are strings with a maximum length of 64 characters. Values are strings with
                  # a maximum length of 512 characters.
                  metadata: nil
                )
                end

                sig do
                  override.returns(
                    {
                      chunking_strategy:
                        T.any(
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                        ),
                      file_ids: T::Array[String],
                      metadata: T.nilable(T::Hash[Symbol, String])
                    }
                  )
                end
                def to_hash
                end

                # The chunking strategy used to chunk the file(s). If not set, will use the `auto`
                # strategy.
                module ChunkingStrategy
                  extend OpenAI::Internal::Type::Union

                  Variants =
                    T.type_alias do
                      T.any(
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      )
                    end

                  class Auto < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # Always `auto`.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    # The default strategy. This strategy currently uses a `max_chunk_size_tokens` of
                    # `800` and `chunk_overlap_tokens` of `400`.
                    sig { params(type: Symbol).returns(T.attached_class) }
                    def self.new(
                      # Always `auto`.
                      type: :auto
                    )
                    end

                    sig { override.returns({ type: Symbol }) }
                    def to_hash
                    end
                  end

                  class Static < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    sig do
                      returns(
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                      )
                    end
                    attr_reader :static

                    sig do
                      params(
                        static:
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static::OrHash
                      ).void
                    end
                    attr_writer :static

                    # Always `static`.
                    sig { returns(Symbol) }
                    attr_accessor :type

                    sig do
                      params(
                        static:
                          OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static::OrHash,
                        type: Symbol
                      ).returns(T.attached_class)
                    end
                    def self.new(
                      static:,
                      # Always `static`.
                      type: :static
                    )
                    end

                    sig do
                      override.returns(
                        {
                          static:
                            OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                          type: Symbol
                        }
                      )
                    end
                    def to_hash
                    end

                    class Static < OpenAI::Internal::Type::BaseModel
                      OrHash =
                        T.type_alias do
                          T.any(
                            OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                            OpenAI::Internal::AnyHash
                          )
                        end

                      # The number of tokens that overlap between chunks. The default value is `400`.
                      #
                      # Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                      sig { returns(Integer) }
                      attr_accessor :chunk_overlap_tokens

                      # The maximum number of tokens in each chunk. The default value is `800`. The
                      # minimum value is `100` and the maximum value is `4096`.
                      sig { returns(Integer) }
                      attr_accessor :max_chunk_size_tokens

                      sig do
                        params(
                          chunk_overlap_tokens: Integer,
                          max_chunk_size_tokens: Integer
                        ).returns(T.attached_class)
                      end
                      def self.new(
                        # The number of tokens that overlap between chunks. The default value is `400`.
                        #
                        # Note that the overlap must not exceed half of `max_chunk_size_tokens`.
                        chunk_overlap_tokens:,
                        # The maximum number of tokens in each chunk. The default value is `800`. The
                        # minimum value is `100` and the maximum value is `4096`.
                        max_chunk_size_tokens:
                      )
                      end

                      sig do
                        override.returns(
                          {
                            chunk_overlap_tokens: Integer,
                            max_chunk_size_tokens: Integer
                          }
                        )
                      end
                      def to_hash
                      end
                    end
                  end

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Variants
                      ]
                    )
                  end
                  def self.variants
                  end
                end
              end
            end
          end
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter
              )
            )
          end
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter:
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter::OrHash
            ).void
          end
          attr_writer :code_interpreter

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch
              )
            )
          end
          attr_reader :file_search

          sig do
            params(
              file_search:
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch::OrHash
            ).void
          end
          attr_writer :file_search

          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          sig do
            params(
              code_interpreter:
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter::OrHash,
              file_search:
                OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch::OrHash
            ).returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override.returns(
              {
                code_interpreter:
                  OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter,
                file_search:
                  OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch
              }
            )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            # available to the `code_interpreter` tool. There can be a maximum of 20 files
            # associated with the tool.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :file_ids

            sig { params(file_ids: T::Array[String]).void }
            attr_writer :file_ids

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(
              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
              # available to the `code_interpreter` tool. There can be a maximum of 20 files
              # associated with the tool.
              file_ids: nil
            )
            end

            sig { override.returns({ file_ids: T::Array[String] }) }
            def to_hash
            end
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the
            # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            # attached to this assistant. There can be a maximum of 1 vector store attached to
            # the assistant.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :vector_store_ids

            sig { params(vector_store_ids: T::Array[String]).void }
            attr_writer :vector_store_ids

            sig do
              params(vector_store_ids: T::Array[String]).returns(
                T.attached_class
              )
            end
            def self.new(
              # The ID of the
              # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              # attached to this assistant. There can be a maximum of 1 vector store attached to
              # the assistant.
              vector_store_ids: nil
            )
            end

            sig { override.returns({ vector_store_ids: T::Array[String] }) }
            def to_hash
            end
          end
        end

        class TruncationStrategy < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy,
                OpenAI::Internal::AnyHash
              )
            end

          # The truncation strategy to use for the thread. The default is `auto`. If set to
          # `last_messages`, the thread will be truncated to the n most recent messages in
          # the thread. When set to `auto`, messages in the middle of the thread will be
          # dropped to fit the context length of the model, `max_prompt_tokens`.
          sig do
            returns(
              OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol
            )
          end
          attr_accessor :type

          # The number of most recent messages from the thread when constructing the context
          # for the run.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :last_messages

          # Controls for how a thread will be truncated prior to the run. Use this to
          # control the intial context window of the run.
          sig do
            params(
              type:
                OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol,
              last_messages: T.nilable(Integer)
            ).returns(T.attached_class)
          end
          def self.new(
            # The truncation strategy to use for the thread. The default is `auto`. If set to
            # `last_messages`, the thread will be truncated to the n most recent messages in
            # the thread. When set to `auto`, messages in the middle of the thread will be
            # dropped to fit the context length of the model, `max_prompt_tokens`.
            type:,
            # The number of most recent messages from the thread when constructing the context
            # for the run.
            last_messages: nil
          )
          end

          sig do
            override.returns(
              {
                type:
                  OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::OrSymbol,
                last_messages: T.nilable(Integer)
              }
            )
          end
          def to_hash
          end

          # The truncation strategy to use for the thread. The default is `auto`. If set to
          # `last_messages`, the thread will be truncated to the n most recent messages in
          # the thread. When set to `auto`, messages in the middle of the thread will be
          # dropped to fit the context length of the model, `max_prompt_tokens`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::TaggedSymbol
              )
            LAST_MESSAGES =
              T.let(
                :last_messages,
                OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ThreadCreateAndRunParams::TruncationStrategy::Type::TaggedSymbol
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
end
