# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadUpdateParams < OpenAI::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard.
        #
        #   Keys are strings with a maximum length of 64 characters. Values are strings with
        #   a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # A set of resources that are made available to the assistant's tools in this
        #   thread. The resources are specific to the type of tool. For example, the
        #   `code_interpreter` tool requires a list of file IDs, while the `file_search`
        #   tool requires a list of vector store IDs.
        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources)) }
        attr_reader :tool_resources

        sig do
          params(
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, OpenAI::Internal::Util::AnyHash))
          )
            .void
        end
        attr_writer :tool_resources

        sig do
          params(
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources: T.nilable(T.any(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources, OpenAI::Internal::Util::AnyHash)),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::Util::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(metadata: nil, tool_resources: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                metadata: T.nilable(T::Hash[Symbol, String]),
                tool_resources: T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter)) }
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter: T.any(
                OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter,
                OpenAI::Internal::Util::AnyHash
              )
            )
              .void
          end
          attr_writer :code_interpreter

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch)) }
          attr_reader :file_search

          sig do
            params(
              file_search: T.any(
                OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch,
                OpenAI::Internal::Util::AnyHash
              )
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
              code_interpreter: T.any(
                OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter,
                OpenAI::Internal::Util::AnyHash
              ),
              file_search: T.any(
                OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch,
                OpenAI::Internal::Util::AnyHash
              )
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch
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

          class FileSearch < OpenAI::BaseModel
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
