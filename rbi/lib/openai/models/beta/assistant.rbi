# typed: strong

module OpenAI
  module Models
    module Beta
      class Assistant < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        sig { returns(T.nilable(String)) }
        def description
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_)
        end

        sig { returns(T.nilable(String)) }
        def instructions
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def instructions=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(String) }
        def model
        end

        sig { params(_: String).returns(String) }
        def model=(_)
        end

        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ]
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

        sig { returns(T.nilable(Float)) }
        def temperature
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def temperature=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::Assistant::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::Assistant::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::Assistant::ToolResources))
        end
        def tool_resources=(_)
        end

        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        sig do
          params(
            id: String,
            created_at: Integer,
            description: T.nilable(String),
            instructions: T.nilable(String),
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: String,
            name: T.nilable(String),
            tools: T::Array[
            T.any(
              OpenAI::Models::Beta::CodeInterpreterTool,
              OpenAI::Models::Beta::FileSearchTool,
              OpenAI::Models::Beta::FunctionTool
            )
            ],
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            tool_resources: T.nilable(OpenAI::Models::Beta::Assistant::ToolResources),
            top_p: T.nilable(Float),
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          description:,
          instructions:,
          metadata:,
          model:,
          name:,
          tools:,
          response_format: nil,
          temperature: nil,
          tool_resources: nil,
          top_p: nil,
          object: :assistant
        )
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                description: T.nilable(String),
                instructions: T.nilable(String),
                metadata: T.nilable(OpenAI::Models::Metadata),
                model: String,
                name: T.nilable(String),
                object: Symbol,
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::FileSearchTool,
                  OpenAI::Models::Beta::FunctionTool
                )
                ],
                response_format: T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                ),
                temperature: T.nilable(Float),
                tool_resources: T.nilable(OpenAI::Models::Beta::Assistant::ToolResources),
                top_p: T.nilable(Float)
              }
            )
        end
        def to_hash
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Assistant::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::Assistant::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::Assistant::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::Assistant::ToolResources::FileSearch
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::Assistant::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::Assistant::ToolResources::FileSearch
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
