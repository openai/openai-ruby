# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageCreateParams < OpenAI::BaseModel
          extend OpenAI::Type::RequestParameters::Converter
          include OpenAI::RequestParameters

          # The text contents of the message.
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
          attr_accessor :content

          # The role of the entity that is creating the message. Allowed values include:
          #
          #   - `user`: Indicates the message is sent by an actual user and should be used in
          #     most cases to represent user-generated messages.
          #   - `assistant`: Indicates the message is generated by the assistant. Use this
          #     value to insert messages from the assistant into the conversation.
          sig { returns(OpenAI::Models::Beta::Threads::MessageCreateParams::Role::OrSymbol) }
          attr_accessor :role

          # A list of files attached to the message, and the tools they should be added to.
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment])) }
          attr_accessor :attachments

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          sig do
            params(
              content: T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Util::AnyHash,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              ),
              role: OpenAI::Models::Beta::Threads::MessageCreateParams::Role::OrSymbol,
              attachments: T.nilable(
                T::Array[T.any(OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment, OpenAI::Util::AnyHash)]
              ),
              metadata: T.nilable(T::Hash[Symbol, String]),
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
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
                  role: OpenAI::Models::Beta::Threads::MessageCreateParams::Role::OrSymbol,
                  attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment]),
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash
          end

          # The text contents of the message.
          module Content
            extend OpenAI::Union

            sig do
              override
                .returns(
                  [
                    String,
                    T::Array[
                                      T.any(
                                        OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                                        OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                                        OpenAI::Models::Beta::Threads::TextContentBlockParam
                                      )
                                      ]
                  ]
                )
            end
            def self.variants
            end

            MessageContentPartParamArray =
              T.let(
                OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContentPartParam],
                OpenAI::Type::Converter
              )
          end

          # The role of the entity that is creating the message. Allowed values include:
          #
          #   - `user`: Indicates the message is sent by an actual user and should be used in
          #     most cases to represent user-generated messages.
          #   - `assistant`: Indicates the message is generated by the assistant. Use this
          #     value to insert messages from the assistant into the conversation.
          module Role
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Role) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Role::TaggedSymbol) }

            USER = T.let(:user, OpenAI::Models::Beta::Threads::MessageCreateParams::Role::TaggedSymbol)
            ASSISTANT = T.let(:assistant, OpenAI::Models::Beta::Threads::MessageCreateParams::Role::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Role::TaggedSymbol]) }
            def self.values
            end
          end

          class Attachment < OpenAI::BaseModel
            # The ID of the file to attach to the message.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            # The tools to add this file to.
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
            attr_reader :tools

            sig do
              params(
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Util::AnyHash,
                  OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch
                )
                ]
              )
                .void
            end
            attr_writer :tools

            sig do
              params(
                file_id: String,
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Util::AnyHash,
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

            module Tool
              extend OpenAI::Union

              class FileSearch < OpenAI::BaseModel
                # The type of tool being defined: `file_search`
                sig { returns(Symbol) }
                attr_accessor :type

                sig { params(type: Symbol).returns(T.attached_class) }
                def self.new(type: :file_search)
                end

                sig { override.returns({type: Symbol}) }
                def to_hash
                end
              end

              sig do
                override
                  .returns(
                    [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch]
                  )
              end
              def self.variants
              end
            end
          end
        end
      end
    end
  end
end
