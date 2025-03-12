# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageCreateParams < OpenAI::BaseModel
          extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

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

          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment])) }
          def attachments
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment]))
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
              attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment]),
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
            )
              .returns(T.attached_class)
          end
          def self.new(content:, role:, attachments: nil, metadata: nil, request_options: {})
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
                  attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment]),
                  metadata: T.nilable(OpenAI::Models::Metadata),
                  request_options: OpenAI::RequestOptions
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
                    OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch
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
                  OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch
                )
                ]
              )
                .returns(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch
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
                  OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch
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
                      OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch
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
                      [[Symbol, OpenAI::Models::Beta::CodeInterpreterTool], [Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch]]
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
  end
end
