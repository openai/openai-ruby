# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      # A developer, user, or assistant message supplied as text history before the Live
      # session starts.
      module InitialItem
        extend OpenAI::Internal::Type::Union

        discriminator :role

        # A developer message included in the initial text history of a Live session.
        variant :developer, -> { OpenAI::Live::InitialItem::Developer }

        # A user message included in the initial text history of a Live session.
        variant :user, -> { OpenAI::Live::InitialItem::User }

        # An assistant message included in the initial text history of a Live session.
        variant :assistant, -> { OpenAI::Live::InitialItem::Assistant }

        class Developer < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #   The message content. Supply exactly one text part for the initial Live
          #   conversation history.
          #
          #   @return [Array<OpenAI::Models::Live::InitialItem::Developer::Content>]
          required :content, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::InitialItem::Developer::Content] }

          # @!attribute role
          #   The author of this history message. Always `developer`.
          #
          #   @return [Symbol, :developer]
          required :role, const: :developer

          # @!attribute id
          #   An optional identifier for the supplied history message. Live uses the message’s
          #   role and text to initialize the conversation.
          #
          #   @return [String, nil]
          optional :id, String, nil?: true

          # @!attribute status
          #   The supplied message’s status. Live uses its text as history and does not resume
          #   an incomplete message.
          #
          #   @return [Symbol, OpenAI::Models::Live::InitialItem::Developer::Status, nil]
          optional :status, enum: -> { OpenAI::Live::InitialItem::Developer::Status }, nil?: true

          # @!attribute type
          #   The history item type. Always `message`.
          #
          #   @return [Symbol, OpenAI::Models::Live::InitialItem::Developer::Type, nil]
          optional :type, enum: -> { OpenAI::Live::InitialItem::Developer::Type }

          # @!method initialize(content:, id: nil, status: nil, type: nil, role: :developer)
          #   A developer message included in the initial text history of a Live session.
          #
          #   @param content [Array<OpenAI::Models::Live::InitialItem::Developer::Content>]
          #     The message content. Supply exactly one text part for the initial Live
          #     conversation history.
          #
          #   @param id [String, nil]
          #     An optional identifier for the supplied history message. Live uses the message’s
          #     role and text to initialize the conversation.
          #
          #   @param status [Symbol, OpenAI::Models::Live::InitialItem::Developer::Status, nil]
          #     The supplied message’s status. Live uses its text as history and does not resume
          #     an incomplete message.
          #
          #   @param type [Symbol, OpenAI::Models::Live::InitialItem::Developer::Type]
          #     The history item type. Always `message`.
          #
          #   @param role [Symbol, :developer]
          #     The author of this history message. Always `developer`.
          class Content < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The message text to include in the Live session’s initial conversation history.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   The text content type. Always `input_text`.
            #
            #   @return [Symbol, OpenAI::Models::Live::InitialItem::Developer::Content::Type, nil]
            optional :type, enum: -> { OpenAI::Live::InitialItem::Developer::Content::Type }

            # @!method initialize(text:, type: nil)
            #   Text supplied in a developer or user message when starting a Live session.
            #
            #   @param text [String]
            #     The message text to include in the Live session’s initial conversation history.
            #
            #   @param type [Symbol, OpenAI::Models::Live::InitialItem::Developer::Content::Type]
            #     The text content type. Always `input_text`.

            # The text content type. Always `input_text`.
            #
            # @see OpenAI::Models::Live::InitialItem::Developer::Content#type
            module Type
              extend OpenAI::Internal::Type::Enum

              INPUT_TEXT = :input_text

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          #
          # @see OpenAI::Models::Live::InitialItem::Developer#status
          module Status
            extend OpenAI::Internal::Type::Enum

            INCOMPLETE = :incomplete
            COMPLETED = :completed

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The history item type. Always `message`.
          #
          # @see OpenAI::Models::Live::InitialItem::Developer#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class User < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #   The message content. Supply exactly one text part for the initial Live
          #   conversation history.
          #
          #   @return [Array<OpenAI::Models::Live::InitialItem::User::Content>]
          required :content, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Live::InitialItem::User::Content] }

          # @!attribute role
          #   The author of this history message. Always `user`.
          #
          #   @return [Symbol, :user]
          required :role, const: :user

          # @!attribute id
          #   An optional identifier for the supplied history message. Live uses the message’s
          #   role and text to initialize the conversation.
          #
          #   @return [String, nil]
          optional :id, String, nil?: true

          # @!attribute status
          #   The supplied message’s status. Live uses its text as history and does not resume
          #   an incomplete message.
          #
          #   @return [Symbol, OpenAI::Models::Live::InitialItem::User::Status, nil]
          optional :status, enum: -> { OpenAI::Live::InitialItem::User::Status }, nil?: true

          # @!attribute type
          #   The history item type. Always `message`.
          #
          #   @return [Symbol, OpenAI::Models::Live::InitialItem::User::Type, nil]
          optional :type, enum: -> { OpenAI::Live::InitialItem::User::Type }

          # @!method initialize(content:, id: nil, status: nil, type: nil, role: :user)
          #   A user message included in the initial text history of a Live session.
          #
          #   @param content [Array<OpenAI::Models::Live::InitialItem::User::Content>]
          #     The message content. Supply exactly one text part for the initial Live
          #     conversation history.
          #
          #   @param id [String, nil]
          #     An optional identifier for the supplied history message. Live uses the message’s
          #     role and text to initialize the conversation.
          #
          #   @param status [Symbol, OpenAI::Models::Live::InitialItem::User::Status, nil]
          #     The supplied message’s status. Live uses its text as history and does not resume
          #     an incomplete message.
          #
          #   @param type [Symbol, OpenAI::Models::Live::InitialItem::User::Type]
          #     The history item type. Always `message`.
          #
          #   @param role [Symbol, :user]
          #     The author of this history message. Always `user`.
          class Content < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The message text to include in the Live session’s initial conversation history.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   The text content type. Always `input_text`.
            #
            #   @return [Symbol, OpenAI::Models::Live::InitialItem::User::Content::Type, nil]
            optional :type, enum: -> { OpenAI::Live::InitialItem::User::Content::Type }

            # @!method initialize(text:, type: nil)
            #   Text supplied in a developer or user message when starting a Live session.
            #
            #   @param text [String]
            #     The message text to include in the Live session’s initial conversation history.
            #
            #   @param type [Symbol, OpenAI::Models::Live::InitialItem::User::Content::Type]
            #     The text content type. Always `input_text`.

            # The text content type. Always `input_text`.
            #
            # @see OpenAI::Models::Live::InitialItem::User::Content#type
            module Type
              extend OpenAI::Internal::Type::Enum

              INPUT_TEXT = :input_text

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          #
          # @see OpenAI::Models::Live::InitialItem::User#status
          module Status
            extend OpenAI::Internal::Type::Enum

            INCOMPLETE = :incomplete
            COMPLETED = :completed

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The history item type. Always `message`.
          #
          # @see OpenAI::Models::Live::InitialItem::User#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class Assistant < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #   The message content. Supply exactly one text part for the initial Live
          #   conversation history.
          #
          #   @return [Array<OpenAI::Models::Live::InitialItem::Assistant::Content::Text, OpenAI::Models::Live::InitialItem::Assistant::Content::OutputText>]
          required(
            :content,
            -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::InitialItem::Assistant::Content] }
          )

          # @!attribute role
          #   The author of this history message. Always `assistant`.
          #
          #   @return [Symbol, :assistant]
          required :role, const: :assistant

          # @!attribute id
          #   An optional identifier for the supplied history message. Live uses the message’s
          #   role and text to initialize the conversation.
          #
          #   @return [String, nil]
          optional :id, String, nil?: true

          # @!attribute status
          #   The supplied message’s status. Live uses its text as history and does not resume
          #   an incomplete message.
          #
          #   @return [Symbol, OpenAI::Models::Live::InitialItem::Assistant::Status, nil]
          optional :status, enum: -> { OpenAI::Live::InitialItem::Assistant::Status }, nil?: true

          # @!attribute type
          #   The history item type. Always `message`.
          #
          #   @return [Symbol, OpenAI::Models::Live::InitialItem::Assistant::Type, nil]
          optional :type, enum: -> { OpenAI::Live::InitialItem::Assistant::Type }

          # @!method initialize(content:, id: nil, status: nil, type: nil, role: :assistant)
          #   An assistant message included in the initial text history of a Live session.
          #
          #   @param content [Array<OpenAI::Models::Live::InitialItem::Assistant::Content::Text, OpenAI::Models::Live::InitialItem::Assistant::Content::OutputText>]
          #     The message content. Supply exactly one text part for the initial Live
          #     conversation history.
          #
          #   @param id [String, nil]
          #     An optional identifier for the supplied history message. Live uses the message’s
          #     role and text to initialize the conversation.
          #
          #   @param status [Symbol, OpenAI::Models::Live::InitialItem::Assistant::Status, nil]
          #     The supplied message’s status. Live uses its text as history and does not resume
          #     an incomplete message.
          #
          #   @param type [Symbol, OpenAI::Models::Live::InitialItem::Assistant::Type]
          #     The history item type. Always `message`.
          #
          #   @param role [Symbol, :assistant]
          #     The author of this history message. Always `assistant`.

          # Assistant text supplied as conversation history when starting a Live session.
          module Content
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Assistant text supplied as conversation history when starting a Live session.
            variant :text, -> { OpenAI::Live::InitialItem::Assistant::Content::Text }

            # Assistant output text supplied as conversation history when starting a Live session.
            variant :output_text, -> { OpenAI::Live::InitialItem::Assistant::Content::OutputText }

            class Text < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #   The message text to include in the Live session’s initial conversation history.
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #   The text content type. Always `text`.
              #
              #   @return [Symbol, OpenAI::Models::Live::InitialItem::Assistant::Content::Text::Type, nil]
              optional :type, enum: -> { OpenAI::Live::InitialItem::Assistant::Content::Text::Type }

              # @!method initialize(text:, type: nil)
              #   Assistant text supplied as conversation history when starting a Live session.
              #
              #   @param text [String]
              #     The message text to include in the Live session’s initial conversation history.
              #
              #   @param type [Symbol, OpenAI::Models::Live::InitialItem::Assistant::Content::Text::Type]
              #     The text content type. Always `text`.

              # The text content type. Always `text`.
              #
              # @see OpenAI::Models::Live::InitialItem::Assistant::Content::Text#type
              module Type
                extend OpenAI::Internal::Type::Enum

                TEXT = :text

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class OutputText < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #   The message text to include in the Live session’s initial conversation history.
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #   The text content type. Always `output_text`.
              #
              #   @return [Symbol, :output_text]
              required :type, const: :output_text

              # @!method initialize(text:, type: :output_text)
              #   Assistant output text supplied as conversation history when starting a Live
              #   session.
              #
              #   @param text [String]
              #     The message text to include in the Live session’s initial conversation history.
              #
              #   @param type [Symbol, :output_text]
              #     The text content type. Always `output_text`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Live::InitialItem::Assistant::Content::Text, OpenAI::Models::Live::InitialItem::Assistant::Content::OutputText)]
          end

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          #
          # @see OpenAI::Models::Live::InitialItem::Assistant#status
          module Status
            extend OpenAI::Internal::Type::Enum

            INCOMPLETE = :incomplete
            COMPLETED = :completed

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The history item type. Always `message`.
          #
          # @see OpenAI::Models::Live::InitialItem::Assistant#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Live::InitialItem::Developer, OpenAI::Models::Live::InitialItem::User, OpenAI::Models::Live::InitialItem::Assistant)]
      end
    end
  end
end
