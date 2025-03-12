# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class RunCreateParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          sig { returns(String) }
          def assistant_id
          end

          sig { params(_: String).returns(String) }
          def assistant_id=(_)
          end

          sig { returns(T.nilable(T::Array[Symbol])) }
          def include
          end

          sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
          def include=(_)
          end

          sig { returns(T.nilable(String)) }
          def additional_instructions
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def additional_instructions=(_)
          end

          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage])) }
          def additional_messages
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]))
          end
          def additional_messages=(_)
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

          sig { returns(T.nilable(Symbol)) }
          def reasoning_effort
          end

          sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
          def reasoning_effort=(_)
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

          sig { returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice))) }
          def tool_choice
          end

          sig do
            params(_: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
              .returns(T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)))
          end
          def tool_choice=(_)
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

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy)) }
          def truncation_strategy
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy))
          end
          def truncation_strategy=(_)
          end

          sig do
            params(
              assistant_id: String,
              include: T::Array[Symbol],
              additional_instructions: T.nilable(String),
              additional_messages: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]),
              instructions: T.nilable(String),
              max_completion_tokens: T.nilable(Integer),
              max_prompt_tokens: T.nilable(Integer),
              metadata: T.nilable(OpenAI::Models::Metadata),
              model: T.nilable(T.any(String, Symbol)),
              parallel_tool_calls: T::Boolean,
              reasoning_effort: T.nilable(Symbol),
              response_format: T.nilable(
                T.any(
                  Symbol,
                  OpenAI::Models::ResponseFormatText,
                  OpenAI::Models::ResponseFormatJSONObject,
                  OpenAI::Models::ResponseFormatJSONSchema
                )
              ),
              temperature: T.nilable(Float),
              tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
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
              truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy),
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
            )
              .returns(T.attached_class)
          end
          def self.new(
            assistant_id:,
            include: nil,
            additional_instructions: nil,
            additional_messages: nil,
            instructions: nil,
            max_completion_tokens: nil,
            max_prompt_tokens: nil,
            metadata: nil,
            model: nil,
            parallel_tool_calls: nil,
            reasoning_effort: nil,
            response_format: nil,
            temperature: nil,
            tool_choice: nil,
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
                  include: T::Array[Symbol],
                  additional_instructions: T.nilable(String),
                  additional_messages: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage]),
                  instructions: T.nilable(String),
                  max_completion_tokens: T.nilable(Integer),
                  max_prompt_tokens: T.nilable(Integer),
                  metadata: T.nilable(OpenAI::Models::Metadata),
                  model: T.nilable(T.any(String, Symbol)),
                  parallel_tool_calls: T::Boolean,
                  reasoning_effort: T.nilable(Symbol),
                  response_format: T.nilable(
                    T.any(
                      Symbol,
                      OpenAI::Models::ResponseFormatText,
                      OpenAI::Models::ResponseFormatJSONObject,
                      OpenAI::Models::ResponseFormatJSONSchema
                    )
                  ),
                  temperature: T.nilable(Float),
                  tool_choice: T.nilable(T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice)),
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
                  truncation_strategy: T.nilable(OpenAI::Models::Beta::Threads::RunCreateParams::TruncationStrategy),
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end

          class AdditionalMessage < OpenAI::BaseModel
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

            sig do
              returns(
                T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment])
              )
            end
            def attachments
            end

            sig do
              params(
                _: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment])
              )
                .returns(
                  T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment])
                )
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
                attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment]),
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
                    attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment]),
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
                      OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
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
                    OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
                  )
                  ]
                )
                  .returns(
                    T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
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
                    OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
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
                        OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch
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
                        [[Symbol, OpenAI::Models::Beta::CodeInterpreterTool], [Symbol, OpenAI::Models::Beta::Threads::RunCreateParams::AdditionalMessage::Attachment::Tool::FileSearch]]
                      )
                  end
                  private def variants
                  end
                end
              end
            end
          end

          class Model < OpenAI::Union
            abstract!

            class << self
              sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
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
end
