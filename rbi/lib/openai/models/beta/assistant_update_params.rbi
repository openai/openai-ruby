# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantUpdateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The description of the assistant. The maximum length is 512 characters.
        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_)
        end

        # The system instructions that the assistant uses. The maximum length is 256,000
        #   characters.
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
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata
        end

        sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
        def metadata=(_)
        end

        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        sig { returns(T.nilable(T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol))) }
        def model
        end

        sig do
          params(_: T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol))
            .returns(T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol))
        end
        def model=(_)
        end

        # The name of the assistant. The maximum length is 256 characters.
        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_)
        end

        # **o-series models only**
        #
        #   Constrains effort on reasoning for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #   result in faster responses and fewer tokens used on reasoning in a response.
        sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol)) }
        def reasoning_effort
        end

        sig do
          params(_: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol))
            .returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol))
        end
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

        # A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources))
        end
        def tool_resources=(_)
        end

        # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        #   assistant. Tools can be of types `code_interpreter`, `file_search`, or
        #   `function`.
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
            _: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
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
        #   We generally recommend altering this or temperature but not both.
        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        sig do
          params(
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol),
            name: T.nilable(String),
            reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          description: nil,
          instructions: nil,
          metadata: nil,
          model: nil,
          name: nil,
          reasoning_effort: nil,
          response_format: nil,
          temperature: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                description: T.nilable(String),
                instructions: T.nilable(String),
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol),
                name: T.nilable(String),
                reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
                response_format: T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                ),
                temperature: T.nilable(Float),
                tool_resources: T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources),
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ],
                top_p: T.nilable(Float),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        module Model
          extend OpenAI::Union

          Variants =
            type_template(:out) { {fixed: T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)} }

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol) }

          O3_MINI = T.let(:"o3-mini", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          O3_MINI_2025_01_31 =
            T.let(:"o3-mini-2025-01-31", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          O1 = T.let(:o1, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          O1_2024_12_17 = T.let(:"o1-2024-12-17", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4O = T.let(:"gpt-4o", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4O_2024_11_20 =
            T.let(:"gpt-4o-2024-11-20", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4O_2024_08_06 =
            T.let(:"gpt-4o-2024-08-06", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4O_2024_05_13 =
            T.let(:"gpt-4o-2024-05-13", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4O_MINI = T.let(:"gpt-4o-mini", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4O_MINI_2024_07_18 =
            T.let(:"gpt-4o-mini-2024-07-18", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_5_PREVIEW = T.let(:"gpt-4.5-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_5_PREVIEW_2025_02_27 =
            T.let(:"gpt-4.5-preview-2025-02-27", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_TURBO = T.let(:"gpt-4-turbo", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_TURBO_2024_04_09 =
            T.let(:"gpt-4-turbo-2024-04-09", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_0125_PREVIEW =
            T.let(:"gpt-4-0125-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_TURBO_PREVIEW =
            T.let(:"gpt-4-turbo-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_1106_PREVIEW =
            T.let(:"gpt-4-1106-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_VISION_PREVIEW =
            T.let(:"gpt-4-vision-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4 = T.let(:"gpt-4", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_0314 = T.let(:"gpt-4-0314", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_0613 = T.let(:"gpt-4-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_32K = T.let(:"gpt-4-32k", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_32K_0314 = T.let(:"gpt-4-32k-0314", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_4_32K_0613 = T.let(:"gpt-4-32k-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_3_5_TURBO = T.let(:"gpt-3.5-turbo", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_3_5_TURBO_16K =
            T.let(:"gpt-3.5-turbo-16k", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_3_5_TURBO_0613 =
            T.let(:"gpt-3.5-turbo-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_3_5_TURBO_1106 =
            T.let(:"gpt-3.5-turbo-1106", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_3_5_TURBO_0125 =
            T.let(:"gpt-3.5-turbo-0125", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
          GPT_3_5_TURBO_16K_0613 =
            T.let(:"gpt-3.5-turbo-16k-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          # A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch
                }
              )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::BaseModel
            # Overrides the list of
            #   [file](https://platform.openai.com/docs/api-reference/files) IDs made available
            #   to the `code_interpreter` tool. There can be a maximum of 20 files associated
            #   with the tool.
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
            # Overrides the
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
      end
    end
  end
end
