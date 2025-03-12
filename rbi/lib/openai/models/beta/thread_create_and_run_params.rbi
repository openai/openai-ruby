# typed: strong

module OpenAI
  module Models
    module Beta
      class ThreadCreateAndRunParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(String) }
        def assistant_id
        end

        sig { params(_: String).returns(String) }
        def assistant_id=(_)
        end

        sig { returns(T.nilable(String)) }
        def instructions
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def instructions=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_completion_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_completion_tokens=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def max_prompt_tokens
        end

        sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def max_prompt_tokens=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig { returns(T.nilable(T.any(String, Symbol))) }
        def model
        end

        sig { params(_: T.nilable(T.any(String, Symbol))).returns(T.nilable(T.any(String, Symbol))) }
        def model=(_)
        end

        sig { returns(T.nilable(T::Boolean)) }
        def parallel_tool_calls
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def parallel_tool_calls=(_)
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

        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread)) }
        def thread
        end

        sig do
          params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread)
            .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread)
        end
        def thread=(_)
        end

        sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice))) }
        def tool_choice
        end

        sig do
          params(_: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
            .returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
        end
        def tool_choice=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources)) }
        def tool_resources
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources))
            .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources))
        end
        def tool_resources=(_)
        end

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
            _: T.nilable(
              T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ]
            )
          )
            .returns(
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
        def tools=(_)
        end

        sig { returns(T.nilable(Float)) }
        def top_p
        end

        sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
        def top_p=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy)) }
        def truncation_strategy
        end

        sig do
          params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy))
            .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy))
        end
        def truncation_strategy=(_)
        end

        sig do
          params(
            assistant_id: String,
            instructions: T.nilable(String),
            max_completion_tokens: T.nilable(Integer),
            max_prompt_tokens: T.nilable(Integer),
            metadata: T.nilable(OpenAI::Models::Metadata),
            model: T.nilable(T.any(String, Symbol)),
            parallel_tool_calls: T::Boolean,
            response_format: T.nilable(
              T.any(
                Symbol,
                OpenAI::Models::ResponseFormatText,
                OpenAI::Models::ResponseFormatJSONObject,
                OpenAI::Models::ResponseFormatJSONSchema
              )
            ),
            temperature: T.nilable(Float),
            thread: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread,
            tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
            tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources),
            tools: T.nilable(
              T::Array[
              T.any(
                OpenAI::Models::Beta::CodeInterpreterTool,
                OpenAI::Models::Beta::FileSearchTool,
                OpenAI::Models::Beta::FunctionTool
              )
              ]
            ),
            top_p: T.nilable(Float),
            truncation_strategy: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(
          assistant_id:,
          instructions: nil,
          max_completion_tokens: nil,
          max_prompt_tokens: nil,
          metadata: nil,
          model: nil,
          parallel_tool_calls: nil,
          response_format: nil,
          temperature: nil,
          thread: nil,
          tool_choice: nil,
          tool_resources: nil,
          tools: nil,
          top_p: nil,
          truncation_strategy: nil,
          request_options: {}
        )
        end

        sig do
          override
            .returns(
              {
                assistant_id: String,
                instructions: T.nilable(String),
                max_completion_tokens: T.nilable(Integer),
                max_prompt_tokens: T.nilable(Integer),
                metadata: T.nilable(OpenAI::Models::Metadata),
                model: T.nilable(T.any(String, Symbol)),
                parallel_tool_calls: T::Boolean,
                response_format: T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Models::ResponseFormatText,
                    OpenAI::Models::ResponseFormatJSONObject,
                    OpenAI::Models::ResponseFormatJSONSchema
                  )
                ),
                temperature: T.nilable(Float),
                thread: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread,
                tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
                tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources),
                tools: T.nilable(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::FileSearchTool,
                    OpenAI::Models::Beta::FunctionTool
                  )
                  ]
                ),
                top_p: T.nilable(Float),
                truncation_strategy: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::TruncationStrategy),
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        class Model < OpenAI::Union
          abstract!

          class << self
            sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
            private def variants
            end
          end
        end

        class Thread < OpenAI::BaseModel
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message])) }
          def messages
          end

          sig do
            params(_: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message])
              .returns(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message])
          end
          def messages=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources)) }
          def tool_resources
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources))
              .returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources))
          end
          def tool_resources=(_)
          end

          sig do
            params(
              messages: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message],
              metadata: T.nilable(OpenAI::Models::Metadata),
              tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources)
            )
              .returns(T.attached_class)
          end
          def self.new(messages: nil, metadata: nil, tool_resources: nil)
          end

          sig do
            override
              .returns(
                {
                  messages: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message],
                  metadata: T.nilable(OpenAI::Models::Metadata),
                  tool_resources: T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources)
                }
              )
          end
          def to_hash
          end

          class Message < OpenAI::BaseModel
            sig do
              returns(
                T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                )
              )
            end
            def content
            end

            sig do
              params(
                _: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                )
              )
                .returns(
                  T.any(
                    String,
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                      OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                      OpenAI::Models::Beta::Threads::TextContentBlockParam
                    )
                    ]
                  )
                )
            end
            def content=(_)
            end

            sig { returns(Symbol) }
            def role
            end

            sig { params(_: Symbol).returns(Symbol) }
            def role=(_)
            end

            sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment])) }
            def attachments
            end

            sig do
              params(
                _: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment])
              )
                .returns(T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment]))
            end
            def attachments=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Metadata)) }
            def metadata
            end

            sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
            def metadata=(_)
            end

            sig do
              params(
                content: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlockParam
                  )
                  ]
                ),
                role: Symbol,
                attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment]),
                metadata: T.nilable(OpenAI::Models::Metadata)
              )
                .returns(T.attached_class)
            end
            def self.new(content:, role:, attachments: nil, metadata: nil)
            end

            sig do
              override
                .returns(
                  {
                    content: T.any(
                      String,
                      T::Array[
                      T.any(
                        OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                        OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                        OpenAI::Models::Beta::Threads::TextContentBlockParam
                      )
                      ]
                    ),
                    role: Symbol,
                    attachments: T.nilable(T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment]),
                    metadata: T.nilable(OpenAI::Models::Metadata)
                  }
                )
            end
            def to_hash
            end

            class Content < OpenAI::Union
              abstract!

              MessageContentPartParamArray = T.type_alias do
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              end

              class << self
                sig do
                  override
                    .returns(
                      [
                        [NilClass, String],
                        [
                          NilClass,
                          T::Array[
                                                T.any(
                                                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                                                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                                                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                                                )
                                                ]
                        ]
                      ]
                    )
                end
                private def variants
                end
              end
            end

            class Role < OpenAI::Enum
              abstract!

              USER = :user
              ASSISTANT = :assistant

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end

            class Attachment < OpenAI::BaseModel
              sig { returns(T.nilable(String)) }
              def file_id
              end

              sig { params(_: String).returns(String) }
              def file_id=(_)
              end

              sig do
                returns(
                  T.nilable(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
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
                    OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                  )
                  ]
                )
                  .returns(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                    )
                    ]
                  )
              end
              def tools=(_)
              end

              sig do
                params(
                  file_id: String,
                  tools: T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                  )
                  ]
                )
                  .returns(T.attached_class)
              end
              def self.new(file_id: nil, tools: nil)
              end

              sig do
                override
                  .returns(
                    {
                      file_id: String,
                      tools: T::Array[
                      T.any(
                        OpenAI::Models::Beta::CodeInterpreterTool,
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch
                      )
                      ]
                    }
                  )
              end
              def to_hash
              end

              class Tool < OpenAI::Union
                abstract!

                class FileSearch < OpenAI::BaseModel
                  sig { returns(Symbol) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig { params(type: Symbol).returns(T.attached_class) }
                  def self.new(type: :file_search)
                  end

                  sig { override.returns({type: Symbol}) }
                  def to_hash
                  end
                end

                class << self
                  sig do
                    override
                      .returns(
                        [[Symbol, OpenAI::Models::Beta::CodeInterpreterTool], [Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::Message::Attachment::Tool::FileSearch]]
                      )
                  end
                  private def variants
                  end
                end
              end
            end
          end

          class ToolResources < OpenAI::BaseModel
            sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter)) }
            def code_interpreter
            end

            sig do
              params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter)
                .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter)
            end
            def code_interpreter=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch)) }
            def file_search
            end

            sig do
              params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch)
                .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch)
            end
            def file_search=(_)
            end

            sig do
              params(
                code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter,
                file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch
              )
                .returns(T.attached_class)
            end
            def self.new(code_interpreter: nil, file_search: nil)
            end

            sig do
              override
                .returns(
                  {
                    code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::CodeInterpreter,
                    file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch
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

              sig do
                returns(
                  T.nilable(
                    T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                  )
                )
              end
              def vector_stores
              end

              sig do
                params(
                  _: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                )
                  .returns(
                    T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                  )
              end
              def vector_stores=(_)
              end

              sig do
                params(
                  vector_store_ids: T::Array[String],
                  vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                )
                  .returns(T.attached_class)
              end
              def self.new(vector_store_ids: nil, vector_stores: nil)
              end

              sig do
                override
                  .returns(
                    {
                      vector_store_ids: T::Array[String],
                      vector_stores: T::Array[OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore]
                    }
                  )
              end
              def to_hash
              end

              class VectorStore < OpenAI::BaseModel
                sig do
                  returns(
                    T.nilable(
                      T.any(
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      )
                    )
                  )
                end
                def chunking_strategy
                end

                sig do
                  params(
                    _: T.any(
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    )
                  )
                    .returns(
                      T.any(
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                      )
                    )
                end
                def chunking_strategy=(_)
                end

                sig { returns(T.nilable(T::Array[String])) }
                def file_ids
                end

                sig { params(_: T::Array[String]).returns(T::Array[String]) }
                def file_ids=(_)
                end

                sig { returns(T.nilable(OpenAI::Models::Metadata)) }
                def metadata
                end

                sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
                def metadata=(_)
                end

                sig do
                  params(
                    chunking_strategy: T.any(
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                      OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                    ),
                    file_ids: T::Array[String],
                    metadata: T.nilable(OpenAI::Models::Metadata)
                  )
                    .returns(T.attached_class)
                end
                def self.new(chunking_strategy: nil, file_ids: nil, metadata: nil)
                end

                sig do
                  override
                    .returns(
                      {
                        chunking_strategy: T.any(
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto,
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static
                        ),
                        file_ids: T::Array[String],
                        metadata: T.nilable(OpenAI::Models::Metadata)
                      }
                    )
                end
                def to_hash
                end

                class ChunkingStrategy < OpenAI::Union
                  abstract!

                  class Auto < OpenAI::BaseModel
                    sig { returns(Symbol) }
                    def type
                    end

                    sig { params(_: Symbol).returns(Symbol) }
                    def type=(_)
                    end

                    sig { params(type: Symbol).returns(T.attached_class) }
                    def self.new(type: :auto)
                    end

                    sig { override.returns({type: Symbol}) }
                    def to_hash
                    end
                  end

                  class Static < OpenAI::BaseModel
                    sig do
                      returns(
                        OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                      )
                    end
                    def static
                    end

                    sig do
                      params(
                        _: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                      )
                        .returns(
                          OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static
                        )
                    end
                    def static=(_)
                    end

                    sig { returns(Symbol) }
                    def type
                    end

                    sig { params(_: Symbol).returns(Symbol) }
                    def type=(_)
                    end

                    sig do
                      params(
                        static: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                        type: Symbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(static:, type: :static)
                    end

                    sig do
                      override
                        .returns(
                          {
                            static: OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static::Static,
                            type: Symbol
                          }
                        )
                    end
                    def to_hash
                    end

                    class Static < OpenAI::BaseModel
                      sig { returns(Integer) }
                      def chunk_overlap_tokens
                      end

                      sig { params(_: Integer).returns(Integer) }
                      def chunk_overlap_tokens=(_)
                      end

                      sig { returns(Integer) }
                      def max_chunk_size_tokens
                      end

                      sig { params(_: Integer).returns(Integer) }
                      def max_chunk_size_tokens=(_)
                      end

                      sig do
                        params(
                          chunk_overlap_tokens: Integer,
                          max_chunk_size_tokens: Integer
                        ).returns(T.attached_class)
                      end
                      def self.new(chunk_overlap_tokens:, max_chunk_size_tokens:)
                      end

                      sig do
                        override.returns({chunk_overlap_tokens: Integer, max_chunk_size_tokens: Integer})
                      end
                      def to_hash
                      end
                    end
                  end

                  class << self
                    sig do
                      override
                        .returns(
                          [[Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Auto], [Symbol, OpenAI::Models::Beta::ThreadCreateAndRunParams::Thread::ToolResources::FileSearch::VectorStore::ChunkingStrategy::Static]]
                        )
                    end
                    private def variants
                    end
                  end
                end
              end
            end
          end
        end

        class ToolResources < OpenAI::BaseModel
          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter)) }
          def code_interpreter
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter)
              .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter)
          end
          def code_interpreter=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch)) }
          def file_search
          end

          sig do
            params(_: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch)
              .returns(OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch)
          end
          def file_search=(_)
          end

          sig do
            params(
              code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter,
              file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch
            )
              .returns(T.attached_class)
          end
          def self.new(code_interpreter: nil, file_search: nil)
          end

          sig do
            override
              .returns(
                {
                  code_interpreter: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::CodeInterpreter,
                  file_search: OpenAI::Models::Beta::ThreadCreateAndRunParams::ToolResources::FileSearch
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

        class Tool < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[NilClass, OpenAI::Models::Beta::CodeInterpreterTool], [NilClass, OpenAI::Models::Beta::FileSearchTool], [NilClass, OpenAI::Models::Beta::FunctionTool]]
                )
            end
            private def variants
            end
          end
        end

        class TruncationStrategy < OpenAI::BaseModel
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def last_messages
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def last_messages=(_)
          end

          sig { params(type: Symbol, last_messages: T.nilable(Integer)).returns(T.attached_class) }
          def self.new(type:, last_messages: nil)
          end

          sig { override.returns({type: Symbol, last_messages: T.nilable(Integer)}) }
          def to_hash
          end

          class Type < OpenAI::Enum
            abstract!

            AUTO = :auto
            LAST_MESSAGES = :last_messages

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
