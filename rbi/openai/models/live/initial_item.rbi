# typed: strong

module OpenAI
  module Models

    module Live

      # A developer, user, or assistant message supplied as text history before the Live
      # session starts.
      module InitialItem
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::InitialItem::Developer,
            OpenAI::Live::InitialItem::User,
            OpenAI::Live::InitialItem::Assistant
          )
        end

        class Developer < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::InitialItem::Developer,
              OpenAI::Internal::AnyHash
            )
          end

          # The message content. Supply exactly one text part for the initial Live
          # conversation history.
          sig { returns(T::Array[OpenAI::Live::InitialItem::Developer::Content]) }
          attr_accessor :content

          # The author of this history message. Always `developer`.
          sig { returns(Symbol) }
          attr_accessor :role

          # An optional identifier for the supplied history message. Live uses the message’s
          # role and text to initialize the conversation.
          sig { returns(T.nilable(String)) }
          attr_accessor :id

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          sig { returns(T.nilable(OpenAI::Live::InitialItem::Developer::Status::OrSymbol)) }
          attr_accessor :status

          # The history item type. Always `message`.
          sig { returns(T.nilable(OpenAI::Live::InitialItem::Developer::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Live::InitialItem::Developer::Type::OrSymbol).void }
          attr_writer :type

          # A developer message included in the initial text history of a Live session.
          sig do
            params(

              content: T::Array[OpenAI::Live::InitialItem::Developer::Content::OrHash],

              id: T.nilable(String),

              status: T.nilable(OpenAI::Live::InitialItem::Developer::Status::OrSymbol),

              type: OpenAI::Live::InitialItem::Developer::Type::OrSymbol,

              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The message content. Supply exactly one text part for the initial Live
            # conversation history.
            content:,

            # An optional identifier for the supplied history message. Live uses the message’s
            # role and text to initialize the conversation.
            id: nil,

            # The supplied message’s status. Live uses its text as history and does not resume
            # an incomplete message.
            status: nil,

            # The history item type. Always `message`.
            type: nil,

            # The author of this history message. Always `developer`.

            role: :developer
          )
          end

          sig do
            override.returns(
              {
                content: T::Array[OpenAI::Live::InitialItem::Developer::Content],
                role: Symbol,
                id: T.nilable(String),
                status: T.nilable(OpenAI::Live::InitialItem::Developer::Status::OrSymbol),
                type: OpenAI::Live::InitialItem::Developer::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          class Content < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::InitialItem::Developer::Content,
                OpenAI::Internal::AnyHash
              )
            end

            # The message text to include in the Live session’s initial conversation history.
            sig { returns(String) }
            attr_accessor :text

            # The text content type. Always `input_text`.
            sig { returns(T.nilable(OpenAI::Live::InitialItem::Developer::Content::Type::OrSymbol)) }
            attr_reader :type

            sig { params(type: OpenAI::Live::InitialItem::Developer::Content::Type::OrSymbol).void }
            attr_writer :type

            # Text supplied in a developer or user message when starting a Live session.
            sig do
              params(

                text: String,

                type: OpenAI::Live::InitialItem::Developer::Content::Type::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The message text to include in the Live session’s initial conversation history.
              text:,

              # The text content type. Always `input_text`.

              type: nil
            )
            end

            sig do
              override.returns(
                {text: String, type: OpenAI::Live::InitialItem::Developer::Content::Type::OrSymbol}
              )
            end
            def to_hash
            end

            # The text content type. Always `input_text`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::Developer::Content::Type) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              INPUT_TEXT = T.let(:input_text, OpenAI::Live::InitialItem::Developer::Content::Type::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Live::InitialItem::Developer::Content::Type::TaggedSymbol]) }
              def self.values
              end
            end
          end

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::Developer::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            INCOMPLETE = T.let(:incomplete, OpenAI::Live::InitialItem::Developer::Status::TaggedSymbol)
            COMPLETED = T.let(:completed, OpenAI::Live::InitialItem::Developer::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::Developer::Status::TaggedSymbol]) }
            def self.values
            end
          end

          # The history item type. Always `message`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::Developer::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MESSAGE = T.let(:message, OpenAI::Live::InitialItem::Developer::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::Developer::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        class User < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::InitialItem::User,
              OpenAI::Internal::AnyHash
            )
          end

          # The message content. Supply exactly one text part for the initial Live
          # conversation history.
          sig { returns(T::Array[OpenAI::Live::InitialItem::User::Content]) }
          attr_accessor :content

          # The author of this history message. Always `user`.
          sig { returns(Symbol) }
          attr_accessor :role

          # An optional identifier for the supplied history message. Live uses the message’s
          # role and text to initialize the conversation.
          sig { returns(T.nilable(String)) }
          attr_accessor :id

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          sig { returns(T.nilable(OpenAI::Live::InitialItem::User::Status::OrSymbol)) }
          attr_accessor :status

          # The history item type. Always `message`.
          sig { returns(T.nilable(OpenAI::Live::InitialItem::User::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Live::InitialItem::User::Type::OrSymbol).void }
          attr_writer :type

          # A user message included in the initial text history of a Live session.
          sig do
            params(

              content: T::Array[OpenAI::Live::InitialItem::User::Content::OrHash],

              id: T.nilable(String),

              status: T.nilable(OpenAI::Live::InitialItem::User::Status::OrSymbol),

              type: OpenAI::Live::InitialItem::User::Type::OrSymbol,

              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The message content. Supply exactly one text part for the initial Live
            # conversation history.
            content:,

            # An optional identifier for the supplied history message. Live uses the message’s
            # role and text to initialize the conversation.
            id: nil,

            # The supplied message’s status. Live uses its text as history and does not resume
            # an incomplete message.
            status: nil,

            # The history item type. Always `message`.
            type: nil,

            # The author of this history message. Always `user`.

            role: :user
          )
          end

          sig do
            override.returns(
              {
                content: T::Array[OpenAI::Live::InitialItem::User::Content],
                role: Symbol,
                id: T.nilable(String),
                status: T.nilable(OpenAI::Live::InitialItem::User::Status::OrSymbol),
                type: OpenAI::Live::InitialItem::User::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          class Content < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::InitialItem::User::Content,
                OpenAI::Internal::AnyHash
              )
            end

            # The message text to include in the Live session’s initial conversation history.
            sig { returns(String) }
            attr_accessor :text

            # The text content type. Always `input_text`.
            sig { returns(T.nilable(OpenAI::Live::InitialItem::User::Content::Type::OrSymbol)) }
            attr_reader :type

            sig { params(type: OpenAI::Live::InitialItem::User::Content::Type::OrSymbol).void }
            attr_writer :type

            # Text supplied in a developer or user message when starting a Live session.
            sig do
              params(

                text: String,

                type: OpenAI::Live::InitialItem::User::Content::Type::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The message text to include in the Live session’s initial conversation history.
              text:,

              # The text content type. Always `input_text`.

              type: nil
            )
            end

            sig do
              override.returns(
                {text: String, type: OpenAI::Live::InitialItem::User::Content::Type::OrSymbol}
              )
            end
            def to_hash
            end

            # The text content type. Always `input_text`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::User::Content::Type) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              INPUT_TEXT = T.let(:input_text, OpenAI::Live::InitialItem::User::Content::Type::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Live::InitialItem::User::Content::Type::TaggedSymbol]) }
              def self.values
              end
            end
          end

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::User::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            INCOMPLETE = T.let(:incomplete, OpenAI::Live::InitialItem::User::Status::TaggedSymbol)
            COMPLETED = T.let(:completed, OpenAI::Live::InitialItem::User::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::User::Status::TaggedSymbol]) }
            def self.values
            end
          end

          # The history item type. Always `message`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::User::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MESSAGE = T.let(:message, OpenAI::Live::InitialItem::User::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::User::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        class Assistant < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::InitialItem::Assistant,
              OpenAI::Internal::AnyHash
            )
          end

          # The message content. Supply exactly one text part for the initial Live
          # conversation history.
          sig {
            returns(
              T::Array[
                T.any(
                  OpenAI::Live::InitialItem::Assistant::Content::Text,
                  OpenAI::Live::InitialItem::Assistant::Content::OutputText
                )
              ]
            )
          }
          attr_accessor :content

          # The author of this history message. Always `assistant`.
          sig { returns(Symbol) }
          attr_accessor :role

          # An optional identifier for the supplied history message. Live uses the message’s
          # role and text to initialize the conversation.
          sig { returns(T.nilable(String)) }
          attr_accessor :id

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          sig { returns(T.nilable(OpenAI::Live::InitialItem::Assistant::Status::OrSymbol)) }
          attr_accessor :status

          # The history item type. Always `message`.
          sig { returns(T.nilable(OpenAI::Live::InitialItem::Assistant::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Live::InitialItem::Assistant::Type::OrSymbol).void }
          attr_writer :type

          # An assistant message included in the initial text history of a Live session.
          sig do
            params(

              content: T::Array[
                T.any(
                  OpenAI::Live::InitialItem::Assistant::Content::Text::OrHash,
                  OpenAI::Live::InitialItem::Assistant::Content::OutputText::OrHash
                )
              ],

              id: T.nilable(String),

              status: T.nilable(OpenAI::Live::InitialItem::Assistant::Status::OrSymbol),

              type: OpenAI::Live::InitialItem::Assistant::Type::OrSymbol,

              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The message content. Supply exactly one text part for the initial Live
            # conversation history.
            content:,

            # An optional identifier for the supplied history message. Live uses the message’s
            # role and text to initialize the conversation.
            id: nil,

            # The supplied message’s status. Live uses its text as history and does not resume
            # an incomplete message.
            status: nil,

            # The history item type. Always `message`.
            type: nil,

            # The author of this history message. Always `assistant`.

            role: :assistant
          )
          end

          sig do
            override.returns(
              {
                content: T::Array[
                  T.any(
                    OpenAI::Live::InitialItem::Assistant::Content::Text,
                    OpenAI::Live::InitialItem::Assistant::Content::OutputText
                  )
                ],
                role: Symbol,
                id: T.nilable(String),
                status: T.nilable(OpenAI::Live::InitialItem::Assistant::Status::OrSymbol),
                type: OpenAI::Live::InitialItem::Assistant::Type::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Assistant text supplied as conversation history when starting a Live session.
          module Content
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Live::InitialItem::Assistant::Content::Text,
                OpenAI::Live::InitialItem::Assistant::Content::OutputText
              )
            }

            class Text < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::InitialItem::Assistant::Content::Text,
                  OpenAI::Internal::AnyHash
                )
              end

              # The message text to include in the Live session’s initial conversation history.
              sig { returns(String) }
              attr_accessor :text

              # The text content type. Always `text`.
              sig { returns(T.nilable(OpenAI::Live::InitialItem::Assistant::Content::Text::Type::OrSymbol)) }
              attr_reader :type

              sig { params(type: OpenAI::Live::InitialItem::Assistant::Content::Text::Type::OrSymbol).void }
              attr_writer :type

              # Assistant text supplied as conversation history when starting a Live session.
              sig do
                params(

                  text: String,

                  type: OpenAI::Live::InitialItem::Assistant::Content::Text::Type::OrSymbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The message text to include in the Live session’s initial conversation history.
                text:,

                # The text content type. Always `text`.

                type: nil
              )
              end

              sig do
                override.returns(
                  {text: String, type: OpenAI::Live::InitialItem::Assistant::Content::Text::Type::OrSymbol}
                )
              end
              def to_hash
              end

              # The text content type. Always `text`.
              module Type
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Live::InitialItem::Assistant::Content::Text::Type)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                TEXT = T.let(:text, OpenAI::Live::InitialItem::Assistant::Content::Text::Type::TaggedSymbol)

                sig {
                  override.returns(T::Array[OpenAI::Live::InitialItem::Assistant::Content::Text::Type::TaggedSymbol])
                }
                def self.values
                end
              end
            end

            class OutputText < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::InitialItem::Assistant::Content::OutputText,
                  OpenAI::Internal::AnyHash
                )
              end

              # The message text to include in the Live session’s initial conversation history.
              sig { returns(String) }
              attr_accessor :text

              # The text content type. Always `output_text`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Assistant output text supplied as conversation history when starting a Live
              # session.
              sig do
                params(

                  text: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The message text to include in the Live session’s initial conversation history.
                text:,

                # The text content type. Always `output_text`.

                type: :output_text
              )
              end

              sig do
                override.returns(
                  {text: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::Assistant::Content::Variants]) }
            def self.variants
            end

          end

          # The supplied message’s status. Live uses its text as history and does not resume
          # an incomplete message.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::Assistant::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            INCOMPLETE = T.let(:incomplete, OpenAI::Live::InitialItem::Assistant::Status::TaggedSymbol)
            COMPLETED = T.let(:completed, OpenAI::Live::InitialItem::Assistant::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::Assistant::Status::TaggedSymbol]) }
            def self.values
            end
          end

          # The history item type. Always `message`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::InitialItem::Assistant::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MESSAGE = T.let(:message, OpenAI::Live::InitialItem::Assistant::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::InitialItem::Assistant::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

        sig { override.returns(T::Array[OpenAI::Live::InitialItem::Variants]) }
        def self.variants
        end

      end

    end

  end
end
