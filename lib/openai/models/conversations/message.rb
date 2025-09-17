# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class Message < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the message.
        #
        #   @return [String]
        required :id, String

        # @!attribute content
        #   The content of the message
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Conversations::TextContent, OpenAI::Models::Conversations::SummaryTextContent, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Conversations::ComputerScreenshotContent, OpenAI::Models::Responses::ResponseInputFile>]
        required :content, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Conversations::Message::Content] }

        # @!attribute role
        #   The role of the message. One of `unknown`, `user`, `assistant`, `system`,
        #   `critic`, `discriminator`, `developer`, or `tool`.
        #
        #   @return [Symbol, OpenAI::Models::Conversations::Message::Role]
        required :role, enum: -> { OpenAI::Conversations::Message::Role }

        # @!attribute status
        #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Conversations::Message::Status]
        required :status, enum: -> { OpenAI::Conversations::Message::Status }

        # @!attribute type
        #   The type of the message. Always set to `message`.
        #
        #   @return [Symbol, :message]
        required :type, const: :message

        # @!method initialize(id:, content:, role:, status:, type: :message)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::Message} for more details.
        #
        #   A message to or from the model.
        #
        #   @param id [String] The unique ID of the message.
        #
        #   @param content [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Conversations::TextContent, OpenAI::Models::Conversations::SummaryTextContent, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Conversations::ComputerScreenshotContent, OpenAI::Models::Responses::ResponseInputFile>] The content of the message
        #
        #   @param role [Symbol, OpenAI::Models::Conversations::Message::Role] The role of the message. One of `unknown`, `user`, `assistant`, `system`, `criti
        #
        #   @param status [Symbol, OpenAI::Models::Conversations::Message::Status] The status of item. One of `in_progress`, `completed`, or `incomplete`. Populate
        #
        #   @param type [Symbol, :message] The type of the message. Always set to `message`.

        # A text input to the model.
        module Content
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A text input to the model.
          variant :input_text, -> { OpenAI::Responses::ResponseInputText }

          # A text output from the model.
          variant :output_text, -> { OpenAI::Responses::ResponseOutputText }

          # A text content.
          variant :text, -> { OpenAI::Conversations::TextContent }

          # A summary text from the model.
          variant :summary_text, -> { OpenAI::Conversations::SummaryTextContent }

          # A refusal from the model.
          variant :refusal, -> { OpenAI::Responses::ResponseOutputRefusal }

          # An image input to the model. Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
          variant :input_image, -> { OpenAI::Responses::ResponseInputImage }

          # A screenshot of a computer.
          variant :computer_screenshot, -> { OpenAI::Conversations::ComputerScreenshotContent }

          # A file input to the model.
          variant :input_file, -> { OpenAI::Responses::ResponseInputFile }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Conversations::TextContent, OpenAI::Models::Conversations::SummaryTextContent, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Conversations::ComputerScreenshotContent, OpenAI::Models::Responses::ResponseInputFile)]
        end

        # The role of the message. One of `unknown`, `user`, `assistant`, `system`,
        # `critic`, `discriminator`, `developer`, or `tool`.
        #
        # @see OpenAI::Models::Conversations::Message#role
        module Role
          extend OpenAI::Internal::Type::Enum

          UNKNOWN = :unknown
          USER = :user
          ASSISTANT = :assistant
          SYSTEM = :system
          CRITIC = :critic
          DISCRIMINATOR = :discriminator
          DEVELOPER = :developer
          TOOL = :tool

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Conversations::Message#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
