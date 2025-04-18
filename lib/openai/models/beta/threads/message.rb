# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @see OpenAI::Resources::Beta::Threads::Messages#create
        class Message < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute assistant_id
          #   If applicable, the ID of the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) that
          #   authored this message.
          #
          #   @return [String, nil]
          required :assistant_id, String, nil?: true

          # @!attribute attachments
          #   A list of files attached to the message, and the tools they were added to.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::Message::Attachment>, nil]
          required :attachments,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::Threads::Message::Attachment] },
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
          required :content,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::MessageContent] }

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
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          #
          #   @return [Hash{Symbol=>String}, nil]
          required :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

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
          #   associated with the creation of this message. Value is `null` when messages are
          #   created manually using the create message or create thread endpoints.
          #
          #   @return [String, nil]
          required :run_id, String, nil?: true

          # @!attribute status
          #   The status of the message, which can be either `in_progress`, `incomplete`, or
          #   `completed`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::Message::Status]
          required :status, enum: -> { OpenAI::Models::Beta::Threads::Message::Status }

          # @!attribute thread_id
          #   The [thread](https://platform.openai.com/docs/api-reference/threads) ID that
          #   this message belongs to.
          #
          #   @return [String]
          required :thread_id, String

          # @!method initialize(id:, assistant_id:, attachments:, completed_at:, content:, created_at:, incomplete_at:, incomplete_details:, metadata:, role:, run_id:, status:, thread_id:, object: :"thread.message")
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @param id [String]
          #   @param assistant_id [String, nil]
          #   @param attachments [Array<OpenAI::Models::Beta::Threads::Message::Attachment>, nil]
          #   @param completed_at [Integer, nil]
          #   @param content [Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlock, OpenAI::Models::Beta::Threads::RefusalContentBlock>]
          #   @param created_at [Integer]
          #   @param incomplete_at [Integer, nil]
          #   @param incomplete_details [OpenAI::Models::Beta::Threads::Message::IncompleteDetails, nil]
          #   @param metadata [Hash{Symbol=>String}, nil]
          #   @param role [Symbol, OpenAI::Models::Beta::Threads::Message::Role]
          #   @param run_id [String, nil]
          #   @param status [Symbol, OpenAI::Models::Beta::Threads::Message::Status]
          #   @param thread_id [String]
          #   @param object [Symbol, :"thread.message"]

          class Attachment < OpenAI::Internal::Type::BaseModel
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
            optional :tools,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::Message::Attachment::Tool] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly>]
            #   attr_writer :tools

            # @!method initialize(file_id: nil, tools: nil)
            #   @param file_id [String]
            #   @param tools [Array<OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly>]

            module Tool
              extend OpenAI::Internal::Type::Union

              variant -> { OpenAI::Models::Beta::CodeInterpreterTool }

              variant -> { OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly }

              class AssistantToolsFileSearchTypeOnly < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   The type of tool being defined: `file_search`
                #
                #   @return [Symbol, :file_search]
                required :type, const: :file_search

                # @!method initialize(type: :file_search)
                #   @param type [Symbol, :file_search]
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly)]
            end
          end

          # @see OpenAI::Models::Beta::Threads::Message#incomplete_details
          class IncompleteDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute reason
            #   The reason the message is incomplete.
            #
            #   @return [Symbol, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason]
            required :reason, enum: -> { OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason }

            # @!method initialize(reason:)
            #   On an incomplete message, details about why the message is incomplete.
            #
            #   @param reason [Symbol, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason]

            # The reason the message is incomplete.
            #
            # @see OpenAI::Models::Beta::Threads::Message::IncompleteDetails#reason
            module Reason
              extend OpenAI::Internal::Type::Enum

              CONTENT_FILTER = :content_filter
              MAX_TOKENS = :max_tokens
              RUN_CANCELLED = :run_cancelled
              RUN_EXPIRED = :run_expired
              RUN_FAILED = :run_failed

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # The entity that produced the message. One of `user` or `assistant`.
          #
          # @see OpenAI::Models::Beta::Threads::Message#role
          module Role
            extend OpenAI::Internal::Type::Enum

            USER = :user
            ASSISTANT = :assistant

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The status of the message, which can be either `in_progress`, `incomplete`, or
          # `completed`.
          #
          # @see OpenAI::Models::Beta::Threads::Message#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            INCOMPLETE = :incomplete
            COMPLETED = :completed

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
