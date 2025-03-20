# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageCreateParams < OpenAI::BaseModel
          # @!parse
          #   extend OpenAI::RequestParameters::Converter
          include OpenAI::RequestParameters

          # @!attribute content
          #   The text contents of the message.
          #
          #   @return [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
          required :content, union: -> { OpenAI::Models::Beta::Threads::MessageCreateParams::Content }

          # @!attribute role
          #   The role of the entity that is creating the message. Allowed values include:
          #
          #     - `user`: Indicates the message is sent by an actual user and should be used in
          #       most cases to represent user-generated messages.
          #     - `assistant`: Indicates the message is generated by the assistant. Use this
          #       value to insert messages from the assistant into the conversation.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Role]
          required :role, enum: -> { OpenAI::Models::Beta::Threads::MessageCreateParams::Role }

          # @!attribute attachments
          #   A list of files attached to the message, and the tools they should be added to.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment>, nil]
          optional :attachments,
                   -> { OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment] },
                   nil?: true

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #     for storing additional information about the object in a structured format, and
          #     querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :metadata, OpenAI::HashOf[String], nil?: true

          # @!parse
          #   # @param content [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
          #   # @param role [Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Role]
          #   # @param attachments [Array<OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment>, nil]
          #   # @param metadata [Hash{Symbol=>String}, nil]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(content:, role:, attachments: nil, metadata: nil, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # The text contents of the message.
          module Content
            extend OpenAI::Union

            MessageContentPartParamArray =
              OpenAI::ArrayOf[union: -> { OpenAI::Models::Beta::Threads::MessageContentPartParam }]

            # The text contents of the message.
            variant String

            # An array of content parts with a defined type, each can be of type `text` or images can be passed with `image_url` or `image_file`. Image types are only supported on [Vision-compatible models](https://platform.openai.com/docs/models).
            variant OpenAI::Models::Beta::Threads::MessageCreateParams::Content::MessageContentPartParamArray

            # @!parse
            #   class << self
            #     # @return [Array(String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>)]
            #     def variants; end
            #   end
          end

          # The role of the entity that is creating the message. Allowed values include:
          #
          #   - `user`: Indicates the message is sent by an actual user and should be used in
          #     most cases to represent user-generated messages.
          #   - `assistant`: Indicates the message is generated by the assistant. Use this
          #     value to insert messages from the assistant into the conversation.
          module Role
            extend OpenAI::Enum

            USER = :user
            ASSISTANT = :assistant

            finalize!

            class << self
              # @!parse
              #   # @return [Array<Symbol>]
              #   def values; end
            end
          end

          class Attachment < OpenAI::BaseModel
            # @!attribute [r] file_id
            #   The ID of the file to attach to the message.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :file_id

            # @!attribute [r] tools
            #   The tools to add this file to.
            #
            #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch>, nil]
            optional :tools,
                     -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch>]
            #   attr_writer :tools

            # @!parse
            #   # @param file_id [String]
            #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch>]
            #   #
            #   def initialize(file_id: nil, tools: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            module Tool
              extend OpenAI::Union

              discriminator :type

              variant :code_interpreter, -> { OpenAI::Models::Beta::CodeInterpreterTool }

              variant :file_search,
                      -> { OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch }

              class FileSearch < OpenAI::BaseModel
                # @!attribute type
                #   The type of tool being defined: `file_search`
                #
                #   @return [Symbol, :file_search]
                required :type, const: :file_search

                # @!parse
                #   # @param type [Symbol, :file_search]
                #   #
                #   def initialize(type: :file_search, **) = super

                # def initialize: (Hash | OpenAI::BaseModel) -> void
              end

              # @!parse
              #   class << self
              #     # @return [Array(OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment::Tool::FileSearch)]
              #     def variants; end
              #   end
            end
          end
        end
      end
    end
  end
end
