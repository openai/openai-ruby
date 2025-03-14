# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class Message < OpenAI::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute assistant_id
          #   If applicable, the ID of the
          #     [assistant](https://platform.openai.com/docs/api-reference/assistants) that
          #     authored this message.
          #
          #   @return [String, nil]
          required :assistant_id, String, nil?: true

          # @!attribute attachments
          #   A list of files attached to the message, and the tools they were added to.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::Message::Attachment>, nil]
          required :attachments,
                   -> { OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Message::Attachment] },
                   nil?: true

          # @!attribute completed_at
          #   The Unix timestamp (in seconds) for when the message was completed.
          #
          #   @return [Integer, nil]
          required :completed_at, Integer, nil?: true

          # @!attribute content
          #   The content of the message in array of text and/or images.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlock, OpenAI::Models::Beta::Threads::RefusalContentBlock>]
          required :content, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContent] }

          # @!attribute created_at
          #   The Unix timestamp (in seconds) for when the message was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute incomplete_at
          #   The Unix timestamp (in seconds) for when the message was marked as incomplete.
          #
          #   @return [Integer, nil]
          required :incomplete_at, Integer, nil?: true

          # @!attribute incomplete_details
          #   On an incomplete message, details about why the message is incomplete.
          #
          #   @return [OpenAI::Models::Beta::Threads::Message::IncompleteDetails, nil]
          required :incomplete_details, -> { OpenAI::Models::Beta::Threads::Message::IncompleteDetails }, nil?: true

          # @!attribute metadata
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #     for storing additional information about the object in a structured format, and
          #     querying for objects via API or the dashboard.
          #
          #     Keys are strings with a maximum length of 64 characters. Values are strings with
          #     a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          required :metadata, OpenAI::HashOf[String], nil?: true

          # @!attribute object
          #   The object type, which is always `thread.message`.
          #
          #   @return [Symbol, :"thread.message"]
          required :object, const: :"thread.message"

          # @!attribute role
          #   The entity that produced the message. One of `user` or `assistant`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::Message::Role]
          required :role, enum: -> { OpenAI::Models::Beta::Threads::Message::Role }

          # @!attribute run_id
          #   The ID of the [run](https://platform.openai.com/docs/api-reference/runs)
          #     associated with the creation of this message. Value is `null` when messages are
          #     created manually using the create message or create thread endpoints.
          #
          #   @return [String, nil]
          required :run_id, String, nil?: true

          # @!attribute status
          #   The status of the message, which can be either `in_progress`, `incomplete`, or
          #     `completed`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::Message::Status]
          required :status, enum: -> { OpenAI::Models::Beta::Threads::Message::Status }

          # @!attribute thread_id
          #   The [thread](https://platform.openai.com/docs/api-reference/threads) ID that
          #     this message belongs to.
          #
          #   @return [String]
          required :thread_id, String

          # @!parse
          #   # Represents a message within a
          #   #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #   #
          #   # @param id [String]
          #   # @param assistant_id [String, nil]
          #   # @param attachments [Array<OpenAI::Models::Beta::Threads::Message::Attachment>, nil]
          #   # @param completed_at [Integer, nil]
          #   # @param content [Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlock, OpenAI::Models::Beta::Threads::RefusalContentBlock>]
          #   # @param created_at [Integer]
          #   # @param incomplete_at [Integer, nil]
          #   # @param incomplete_details [OpenAI::Models::Beta::Threads::Message::IncompleteDetails, nil]
          #   # @param metadata [Hash{Symbol=>String}, nil]
          #   # @param role [Symbol, OpenAI::Models::Beta::Threads::Message::Role]
          #   # @param run_id [String, nil]
          #   # @param status [Symbol, OpenAI::Models::Beta::Threads::Message::Status]
          #   # @param thread_id [String]
          #   # @param object [Symbol, :"thread.message"]
          #   #
          #   def initialize(
          #     id:,
          #     assistant_id:,
          #     attachments:,
          #     completed_at:,
          #     content:,
          #     created_at:,
          #     incomplete_at:,
          #     incomplete_details:,
          #     metadata:,
          #     role:,
          #     run_id:,
          #     status:,
          #     thread_id:,
          #     object: :"thread.message",
          #     **
          #   )
          #     super
          #   end

          # def initialize: (Hash | OpenAI::BaseModel) -> void

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
            #   @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly>, nil]
            optional :tools, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::Message::Attachment::Tool] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly>]
            #   attr_writer :tools

            # @!parse
            #   # @param file_id [String]
            #   # @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly>]
            #   #
            #   def initialize(file_id: nil, tools: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @abstract
            class Tool < OpenAI::Union
              variant -> { OpenAI::Models::Beta::CodeInterpreterTool }

              variant -> { OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly }

              class AssistantToolsFileSearchTypeOnly < OpenAI::BaseModel
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
            end
          end

          class IncompleteDetails < OpenAI::BaseModel
            # @!attribute reason
            #   The reason the message is incomplete.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason]
            required :reason, enum: -> { OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason }

            # @!parse
            #   # On an incomplete message, details about why the message is incomplete.
            #   #
            #   # @param reason [Symbol, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason]
            #   #
            #   def initialize(reason:, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @abstract
            #
            # The reason the message is incomplete.
            class Reason < OpenAI::Enum
              CONTENT_FILTER = :content_filter
              MAX_TOKENS = :max_tokens
              RUN_CANCELLED = :run_cancelled
              RUN_EXPIRED = :run_expired
              RUN_FAILED = :run_failed

              finalize!
            end
          end

          # @abstract
          #
          # The entity that produced the message. One of `user` or `assistant`.
          class Role < OpenAI::Enum
            USER = :user
            ASSISTANT = :assistant

            finalize!
          end

          # @abstract
          #
          # The status of the message, which can be either `in_progress`, `incomplete`, or
          #   `completed`.
          class Status < OpenAI::Enum
            IN_PROGRESS = :in_progress
            INCOMPLETE = :incomplete
            COMPLETED = :completed

            finalize!
          end
        end
      end
    end
  end
end
