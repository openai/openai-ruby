# typed: strong

module OpenAI
  module Models
    module Beta
      class Thread < OpenAI::Internal::Type::BaseModel
        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the thread was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The object type, which is always `thread`.
        sig { returns(Symbol) }
        attr_accessor :object

        # A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::Thread::ToolResources)) }
        attr_reader :tool_resources

        sig do
          params(
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::Thread::ToolResources, OpenAI::Internal::AnyHash))
          )
            .void
        end
        attr_writer :tool_resources

        # Represents a thread that contains
        #   [messages](https://platform.openai.com/docs/api-reference/messages).
        sig do
          params(
            id: String,
            created_at: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::Thread::ToolResources, OpenAI::Internal::AnyHash)),
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, created_at:, metadata:, tool_resources:, object: :thread)
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                metadata: T.nilable(T::Hash[Symbol, String]),
                object: Symbol,
                tool_resources: T.nilable(OpenAI::Models::Beta::Thread::ToolResources)
              }
            )
        end
        def to_hash
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter)) }
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter: T.any(OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :code_interpreter

          sig { returns(T.nilable(OpenAI::Models::Beta::Thread::ToolResources::FileSearch)) }
          attr_reader :file_search

          sig do
            params(
              file_search: T.any(OpenAI::Models::Beta::Thread::ToolResources::FileSearch, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :file_search

          # A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
          sig do
            params(
              code_interpreter: T.any(OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter, OpenAI::Internal::AnyHash),
              file_search: T.any(OpenAI::Models::Beta::Thread::ToolResources::FileSearch, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::Thread::ToolResources::FileSearch
                }
              )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            # A list of [file](https://platform.openai.com/docs/api-reference/files) IDs made
            #   available to the `code_interpreter` tool. There can be a maximum of 20 files
            #   associated with the tool.
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
            # The
            #   [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
            #   attached to this thread. There can be a maximum of 1 vector store attached to
            #   the thread.
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
