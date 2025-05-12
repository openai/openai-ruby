# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::ThreadUpdateParams, OpenAI::Internal::AnyHash)
          end

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
          returns(T.nilable(OpenAI::Beta::ThreadUpdateParams::ToolResources))
        end
        attr_reader :tool_resources

        sig do
          params(
            tool_resources:
              T.nilable(OpenAI::Beta::ThreadUpdateParams::ToolResources::OrHash)
          ).void
        end
        attr_writer :tool_resources

        sig do
          params(
            metadata: T.nilable(T::Hash[Symbol, String]),
            tool_resources:
              T.nilable(
                OpenAI::Beta::ThreadUpdateParams::ToolResources::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
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
          tool_resources: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              metadata: T.nilable(T::Hash[Symbol, String]),
              tool_resources:
                T.nilable(OpenAI::Beta::ThreadUpdateParams::ToolResources),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class ToolResources < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ThreadUpdateParams::ToolResources,
                OpenAI::Internal::AnyHash
              )
            end

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter
              )
            )
          end
          attr_reader :code_interpreter

          sig do
            params(
              code_interpreter:
                OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter::OrHash
            ).void
          end
          attr_writer :code_interpreter

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch
              )
            )
          end
          attr_reader :file_search

          sig do
            params(
              file_search:
                OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch::OrHash
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
                OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter::OrHash,
              file_search:
                OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch::OrHash
            ).returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override.returns(
              {
                code_interpreter:
                  OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter,
                file_search:
                  OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch
              }
            )
          end
          def to_hash
          end

          class CodeInterpreter < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter,
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
                  OpenAI::Beta::ThreadUpdateParams::ToolResources::FileSearch,
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

            sig do
              params(vector_store_ids: T::Array[String]).returns(
                T.attached_class
              )
            end
            def self.new(
              # The
              # [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object)
              # attached to this thread. There can be a maximum of 1 vector store attached to
              # the thread.
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
