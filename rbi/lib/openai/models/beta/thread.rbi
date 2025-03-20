# typed: strong

module OpenAI
  module Models
    module Beta
      class Thread < OpenAI::BaseModel
        # The identifier, which can be referenced in API endpoints.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The Unix timestamp (in seconds) for when the thread was created.
        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
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

        # The object type, which is always `thread`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::Thread::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(T.any(OpenAI::Models::Beta::Thread::ToolResources, OpenAI::Util::AnyHash)))
            .returns(T.nilable(T.any(OpenAI::Models::Beta::Thread::ToolResources, OpenAI::Util::AnyHash)))
        end
        def tool_resources=(_)
        end

        # Represents a thread that contains
        #   [messages](https://platform.openai.com/docs/api-reference/messages).
        sig do
          params(
            id: String,
            created_at: Integer,
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources: T.nilable(OpenAI::Models::Beta::Thread::ToolResources),
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

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter, OpenAI::Util::AnyHash))
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Thread::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Thread::ToolResources::FileSearch, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Thread::ToolResources::FileSearch, OpenAI::Util::AnyHash))
          end
          def file_search=(_)
          end

          # A set of resources that are made available to the assistant's tools in this
          #   thread. The resources are specific to the type of tool. For example, the
          #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
          #   tool requires a list of vector store IDs.
          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::Thread::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::Thread::ToolResources::FileSearch
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
