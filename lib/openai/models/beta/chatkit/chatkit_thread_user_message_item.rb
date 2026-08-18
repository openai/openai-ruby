# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatKitThreadUserMessageItem < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the thread item.
          #
          #   @return [String]
          required :id, String

          # @!attribute attachments
          #   Attachments associated with the user message. Defaults to an empty list.
          #
          #   @return [Array<OpenAI::Models::Beta::ChatKit::ChatKitAttachment>]
          required :attachments, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::ChatKit::ChatKitAttachment] }

          # @!attribute content
          #   Ordered content elements supplied by the user.
          #
          #   @return [Array<OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText, OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText>]
          required :content,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content] }

          # @!attribute created_at
          #   Unix timestamp (in seconds) for when the item was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute inference_options
          #   Inference overrides applied to the message. Defaults to null when unset.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions, nil]
          required :inference_options,
                   -> { OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions },
                   nil?: true

          # @!attribute object
          #   Type discriminator that is always `chatkit.thread_item`.
          #
          #   @return [Symbol, :"chatkit.thread_item"]
          required :object, const: :"chatkit.thread_item"

          # @!attribute thread_id
          #   Identifier of the parent thread.
          #
          #   @return [String]
          required :thread_id, String

          # @!attribute type
          #
          #   @return [Symbol, :"chatkit.user_message"]
          required :type, const: :"chatkit.user_message"

          # @!method initialize(id:, attachments:, content:, created_at:, inference_options:, thread_id:, object: :"chatkit.thread_item", type: :"chatkit.user_message")
          #   User-authored messages within a thread.
          #
          #   @param id [String] Identifier of the thread item.
          #
          #   @param attachments [Array<OpenAI::Models::Beta::ChatKit::ChatKitAttachment>] Attachments associated with the user message. Defaults to an empty list.
          #
          #   @param content [Array<OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText, OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText>] Ordered content elements supplied by the user.
          #
          #   @param created_at [Integer] Unix timestamp (in seconds) for when the item was created.
          #
          #   @param inference_options [OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions, nil] Inference overrides applied to the message. Defaults to null when unset.
          #
          #   @param thread_id [String] Identifier of the parent thread.
          #
          #   @param object [Symbol, :"chatkit.thread_item"] Type discriminator that is always `chatkit.thread_item`.
          #
          #   @param type [Symbol, :"chatkit.user_message"]

          # Content blocks that comprise a user message.
          module Content
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Text block that a user contributed to the thread.
            variant :input_text, -> { OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText }

            # Quoted snippet that the user referenced in their message.
            variant :quoted_text, -> { OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText }

            class InputText < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #   Plain-text content supplied by the user.
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #   Type discriminator that is always `input_text`.
              #
              #   @return [Symbol, :input_text]
              required :type, const: :input_text

              # @!method initialize(text:, type: :input_text)
              #   Text block that a user contributed to the thread.
              #
              #   @param text [String] Plain-text content supplied by the user.
              #
              #   @param type [Symbol, :input_text] Type discriminator that is always `input_text`.
            end

            class QuotedText < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #   Quoted text content.
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #   Type discriminator that is always `quoted_text`.
              #
              #   @return [Symbol, :quoted_text]
              required :type, const: :quoted_text

              # @!method initialize(text:, type: :quoted_text)
              #   Quoted snippet that the user referenced in their message.
              #
              #   @param text [String] Quoted text content.
              #
              #   @param type [Symbol, :quoted_text] Type discriminator that is always `quoted_text`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::InputText, OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::Content::QuotedText)]
          end

          # @see OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem#inference_options
          class InferenceOptions < OpenAI::Internal::Type::BaseModel
            # @!attribute model
            #   Model name that generated the response. Defaults to null when using the session
            #   default.
            #
            #   @return [String, nil]
            required :model, String, nil?: true

            # @!attribute tool_choice
            #   Preferred tool to invoke. Defaults to null when ChatKit should auto-select.
            #
            #   @return [OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice, nil]
            required :tool_choice,
                     -> { OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice },
                     nil?: true

            # @!method initialize(model:, tool_choice:)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions}
            #   for more details.
            #
            #   Inference overrides applied to the message. Defaults to null when unset.
            #
            #   @param model [String, nil] Model name that generated the response. Defaults to null when using the session
            #
            #   @param tool_choice [OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions::ToolChoice, nil] Preferred tool to invoke. Defaults to null when ChatKit should auto-select.

            # @see OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem::InferenceOptions#tool_choice
            class ToolChoice < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   Identifier of the requested tool.
              #
              #   @return [String]
              required :id, String

              # @!method initialize(id:)
              #   Preferred tool to invoke. Defaults to null when ChatKit should auto-select.
              #
              #   @param id [String] Identifier of the requested tool.
            end
          end
        end
      end

      ChatKitThreadUserMessageItem = ChatKit::ChatKitThreadUserMessageItem
    end
  end
end
