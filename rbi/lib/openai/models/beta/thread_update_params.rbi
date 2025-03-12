# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadUpdateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources))
        end
        def tool_resources=(_)
        end

        sig do
          params(
            metadata: T.nilable(OpenAI::Models::Metadata),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(metadata: nil, tool_resources: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                metadata: T.nilable(OpenAI::Models::Metadata),
                tool_resources: T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::ThreadUpdateParams::ToolResources::FileSearch
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
