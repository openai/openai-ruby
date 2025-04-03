# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # The description of the assistant. The maximum length is 512 characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # The system instructions that the assistant uses. The maximum length is 256,000
        #   characters.
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

        # ID of the model to use. You can use the
        #   [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        #   see all of your available models, or see our
        #   [Model overview](https://platform.openai.com/docs/models) for descriptions of
        #   them.
        sig { returns(T.nilable(T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol))) }
        attr_reader :model

        sig { params(model: T.any(String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol)).void }
        attr_writer :model

        # The name of the assistant. The maximum length is 256 characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # **o-series models only**
        #
        #   Constrains effort on reasoning for
        #   [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
        #   supported values are `low`, `medium`, and `high`. Reducing reasoning effort can
        #   result in faster responses and fewer tokens used on reasoning in a response.
        sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol)) }
        attr_accessor :reasoning_effort

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
        attr_accessor :response_format

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        #   make the output more random, while lower values like 0.2 will make it more
        #   focused and deterministic.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # A set of resources that are used by the assistant's tools. The resources are
        #   specific to the type of tool. For example, the `code_interpreter` tool requires
        #   a list of file IDs, while the `file_search` tool requires a list of vector store
        #   IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources)) }
        attr_reader :tool_resources

        sig do
          params(
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, OpenAI::Internal::AnyHash))
          )
            .void
        end
        attr_writer :tool_resources

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
        attr_reader :tools

        sig do
          params(
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ]
          )
            .void
        end
        attr_writer :tools

        # An alternative to sampling with temperature, called nucleus sampling, where the
        #   model considers the results of the tokens with top_p probability mass. So 0.1
        #   means only the tokens comprising the top 10% probability mass are considered.
        #
        #   We generally recommend altering this or temperature but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

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
                OpenAI::Internal::AnyHash,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources, OpenAI::Internal::AnyHash)),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            top_p: T.nilable(Float),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
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
          extend OpenAI::Internal::Type::Union

          sig { override.returns([String, OpenAI::Models::Beta::AssistantUpdateParams::Model::OrSymbol]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::AssistantUpdateParams::Model) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol) }

          O3_MINI = T.let(:"o3-mini", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          O3_MINI_2025_01_31 =
            T.let(:"o3-mini-2025-01-31", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          O1 = T.let(:o1, OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          O1_2024_12_17 = T.let(:"o1-2024-12-17", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4O = T.let(:"gpt-4o", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4O_2024_11_20 =
            T.let(:"gpt-4o-2024-11-20", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4O_2024_08_06 =
            T.let(:"gpt-4o-2024-08-06", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4O_2024_05_13 =
            T.let(:"gpt-4o-2024-05-13", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4O_MINI = T.let(:"gpt-4o-mini", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4O_MINI_2024_07_18 =
            T.let(:"gpt-4o-mini-2024-07-18", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_5_PREVIEW =
            T.let(:"gpt-4.5-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_5_PREVIEW_2025_02_27 =
            T.let(:"gpt-4.5-preview-2025-02-27", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_TURBO = T.let(:"gpt-4-turbo", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_TURBO_2024_04_09 =
            T.let(:"gpt-4-turbo-2024-04-09", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_0125_PREVIEW =
            T.let(:"gpt-4-0125-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_TURBO_PREVIEW =
            T.let(:"gpt-4-turbo-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_1106_PREVIEW =
            T.let(:"gpt-4-1106-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_VISION_PREVIEW =
            T.let(:"gpt-4-vision-preview", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4 = T.let(:"gpt-4", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_0314 = T.let(:"gpt-4-0314", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_0613 = T.let(:"gpt-4-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_32K = T.let(:"gpt-4-32k", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_32K_0314 =
            T.let(:"gpt-4-32k-0314", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_4_32K_0613 =
            T.let(:"gpt-4-32k-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO = T.let(:"gpt-3.5-turbo", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO_16K =
            T.let(:"gpt-3.5-turbo-16k", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO_0613 =
            T.let(:"gpt-3.5-turbo-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO_1106 =
            T.let(:"gpt-3.5-turbo-1106", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO_0125 =
            T.let(:"gpt-3.5-turbo-0125", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
          GPT_3_5_TURBO_16K_0613 =
            T.let(:"gpt-3.5-turbo-16k-0613", OpenAI::Models::Beta::AssistantUpdateParams::Model::TaggedSymbol)
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter)) }
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter: T.any(
                OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter,
                OpenAI::Internal::AnyHash
              )
            )
              .void
          end
          attr_writer :code_interpreter

          sig { returns(T.nilable(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch)) }
          attr_reader :file_search

          sig do
            params(
              file_search: T.any(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :file_search

          # A set of resources that are used by the assistant's tools. The resources are
          #   specific to the type of tool. For example, the `code_interpreter` tool requires
          #   a list of file IDs, while the `file_search` tool requires a list of vector store
          #   IDs.
          sig do
            params(
              code_interpreter: T.any(
                OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::CodeInterpreter,
                OpenAI::Internal::AnyHash
              ),
              file_search: T.any(OpenAI::Models::Beta::AssistantUpdateParams::ToolResources::FileSearch, OpenAI::Internal::AnyHash)
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

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # Overrides the list of
            #   [file](https://platform.openai.com/docs/api-reference/files) IDs made available
            #   to the `code_interpreter` tool. There can be a maximum of 20 files associated
            #   with the tool.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :file_ids

            sig { params(file_ids: T::Array[String]).void }
            attr_writer :file_ids

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(file_ids: nil)
            end

            sig { override.returns({file_ids: T::Array[String]}) }
            def to_hash
            end
          end

          class FileSearch < OpenAI::Internal::Type::BaseModel
            # Overrides the
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this assistant. There can be a maximum of 1 vector store attached to
            #   the assistant.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :vector_store_ids

            sig { params(vector_store_ids: T::Array[String]).void }
            attr_writer :vector_store_ids

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
