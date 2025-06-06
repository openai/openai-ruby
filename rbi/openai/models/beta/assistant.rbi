# typed: strong

module OpenAI
  module Models
    module Beta
      class Assistant < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::Assistant, OpenAI::Internal::AnyHash)
          end

        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the assistant was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The description of the assistant. The maximum length is 512 characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :description

        # The system instructions that the assistant uses. The maximum length is 256,000
        # characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :instructions

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # ID of the model to use. You can use the
        # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
        # see all of your available models, or see our
        # [Model overview](https://platform.openai.com/docs/models) for descriptions of
        # them.
        sig { returns(String) }
        attr_accessor :model

        # The name of the assistant. The maximum length is 256 characters.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # The object type, which is always `assistant`.
        sig { returns(Symbol) }
        attr_accessor :object

        # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
        # assistant. Tools can be of types `code_interpreter`, `file_search`, or
        # `function`.
        sig { returns(T::Array[OpenAI::Beta::AssistantTool::Variants]) }
        attr_accessor :tools

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
            T.nilable(OpenAI::Beta::AssistantResponseFormatOption::Variants)
          )
        end
        attr_accessor :response_format

        # What sampling temperature to use, between 0 and 2. Higher values like 0.8 will
        # make the output more random, while lower values like 0.2 will make it more
        # focused and deterministic.
        sig { returns(T.nilable(Float)) }
        attr_accessor :temperature

        # A set of resources that are used by the assistant's tools. The resources are
        # specific to the type of tool. For example, the `code_interpreter` tool requires
        # a list of file IDs, while the `file_search` tool requires a list of vector store
        # IDs.
        sig { returns(T.nilable(OpenAI::Beta::Assistant::ToolResources)) }
        attr_reader :tool_resources

        sig do
          params(
            tool_resources:
              T.nilable(OpenAI::Beta::Assistant::ToolResources::OrHash)
          ).void
        end
        attr_writer :tool_resources

        # An alternative to sampling with temperature, called nucleus sampling, where the
        # model considers the results of the tokens with top_p probability mass. So 0.1
        # means only the tokens comprising the top 10% probability mass are considered.
        #
        # We generally recommend altering this or temperature but not both.
        sig { returns(T.nilable(Float)) }
        attr_accessor :top_p

        # Represents an `assistant` that can call the model and use tools.
        sig do
          params(
            id: String,
            created_at: Integer,
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            name: T.nilable(String),
            tools:
              T::Array[
                T.any(
                  OpenAI::Beta::CodeInterpreterTool::OrHash,
                  OpenAI::Beta::FileSearchTool::OrHash,
                  OpenAI::Beta::FunctionTool::OrHash
                )
              ],
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
            tool_resources:
              T.nilable(OpenAI::Beta::Assistant::ToolResources::OrHash),
            top_p: T.nilable(Float),
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The identifier, which can be referenced in API endpoints.
          id:,
          # The Unix timestamp (in seconds) for when the assistant was created.
          created_at:,
          # The description of the assistant. The maximum length is 512 characters.
          description:,
          # The system instructions that the assistant uses. The maximum length is 256,000
          # characters.
          instructions:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata:,
          # ID of the model to use. You can use the
          # [List models](https://platform.openai.com/docs/api-reference/models/list) API to
          # see all of your available models, or see our
          # [Model overview](https://platform.openai.com/docs/models) for descriptions of
          # them.
          model:,
          # The name of the assistant. The maximum length is 256 characters.
          name:,
          # A list of tool enabled on the assistant. There can be a maximum of 128 tools per
          # assistant. Tools can be of types `code_interpreter`, `file_search`, or
          # `function`.
          tools:,
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
          # A set of resources that are used by the assistant's tools. The resources are
          # specific to the type of tool. For example, the `code_interpreter` tool requires
          # a list of file IDs, while the `file_search` tool requires a list of vector store
          # IDs.
          tool_resources: nil,
          # An alternative to sampling with temperature, called nucleus sampling, where the
          # model considers the results of the tokens with top_p probability mass. So 0.1
          # means only the tokens comprising the top 10% probability mass are considered.
          #
          # We generally recommend altering this or temperature but not both.
          top_p: nil,
          # The object type, which is always `assistant`.
          object: :assistant
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              description: T.nilable(String),
              instructions: T.nilable(String),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: String,
              name: T.nilable(String),
              object: Symbol,
              tools: T::Array[OpenAI::Beta::AssistantTool::Variants],
              response_format:
                T.nilable(
                  OpenAI::Beta::AssistantResponseFormatOption::Variants
                ),
              temperature: T.nilable(Float),
              tool_resources: T.nilable(OpenAI::Beta::Assistant::ToolResources),
              top_p: T.nilable(Float)
            }
          )
        end
        def to_hash
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Assistant::ToolResources,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(OpenAI::Beta::Assistant::ToolResources::CodeInterpreter)
            )
          end
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter:
                OpenAI::Beta::Assistant::ToolResources::CodeInterpreter::OrHash
            ).void
          end
          attr_writer :code_interpreter

          sig do
            returns(
              T.nilable(OpenAI::Beta::Assistant::ToolResources::FileSearch)
            )
          end
          attr_reader :file_search

          sig do
            params(
              file_search:
                OpenAI::Beta::Assistant::ToolResources::FileSearch::OrHash
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
                OpenAI::Beta::Assistant::ToolResources::CodeInterpreter::OrHash,
              file_search:
                OpenAI::Beta::Assistant::ToolResources::FileSearch::OrHash
            ).returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override.returns(
              {
                code_interpreter:
                  OpenAI::Beta::Assistant::ToolResources::CodeInterpreter,
                file_search: OpenAI::Beta::Assistant::ToolResources::FileSearch
              }
            )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Assistant::ToolResources::CodeInterpreter,
                  OpenAI::Internal::AnyHash
                )
              end

            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            # available to the `code_interpreter`` tool. There can be a maximum of 20 files
            # associated with the tool.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :file_ids

            sig { params(file_ids: T::Array[String]).void }
            attr_writer :file_ids

            sig { params(file_ids: T::Array[String]).returns(T.attached_class) }
            def self.new(
              # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
              # available to the `code_interpreter`` tool. There can be a maximum of 20 files
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
                  OpenAI::Beta::Assistant::ToolResources::FileSearch,
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
      end
    end
  end
end
