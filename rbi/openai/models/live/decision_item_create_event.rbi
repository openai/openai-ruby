# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionItemCreateEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionItemCreateEvent,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(OpenAI::Live::DecisionItemCreateEvent::Item) }
        attr_reader :item

        sig { params(item: OpenAI::Live::DecisionItemCreateEvent::Item::OrHash).void }
        attr_writer :item

        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Append an input item for future decisions without starting an evaluation or
        # changing Live voice context.
        sig do
          params(

            item: OpenAI::Live::DecisionItemCreateEvent::Item::OrHash,

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          item:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          type: :"decision.item.create"
        )
        end

        sig do
          override.returns(
            {item: OpenAI::Live::DecisionItemCreateEvent::Item, type: Symbol, event_id: T.nilable(String)}
          )
        end
        def to_hash
        end

        class Item < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DecisionItemCreateEvent::Item,
              OpenAI::Internal::AnyHash
            )
          end

          # The text input to the model.
          sig { returns(OpenAI::Live::DecisionItemCreateEvent::Item::Content::Variants) }
          attr_accessor :content

          # The message role. Always `user`.
          sig { returns(Symbol) }
          attr_accessor :role

          # The unique ID of this message item.
          sig { returns(T.nilable(String)) }
          attr_accessor :id

          sig { returns(T.nilable(OpenAI::Live::DecisionItemCreateEvent::Item::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Live::DecisionItemCreateEvent::Item::Type::OrSymbol).void }
          attr_writer :type

          sig do
            params(

              content: OpenAI::Live::DecisionItemCreateEvent::Item::Content::Variants,

              id: T.nilable(String),

              type: OpenAI::Live::DecisionItemCreateEvent::Item::Type::OrSymbol,

              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The text input to the model.
            content:,

            # The unique ID of this message item.
            id: nil,

            type: nil,

            # The message role. Always `user`.

            role: :user
          )
          end

          sig do
            override.returns(
              {
                content: OpenAI::Live::DecisionItemCreateEvent::Item::Content::Variants,
                role: Symbol,
                id: T.nilable(String),
                type: T.nilable(OpenAI::Live::DecisionItemCreateEvent::Item::Type::OrSymbol)
              }
            )
          end
          def to_hash
          end

          # The text input to the model.
          module Content
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(String, T::Array[OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::Variants])
            }

            module Part
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputText,
                  OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage
                )
              }

              class InputText < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputText,
                    OpenAI::Internal::AnyHash
                  )
                end

                # The text input to the model.
                sig { returns(String) }
                attr_accessor :text

                # The type of the input item. Always `input_text`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(

                    text: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # The text input to the model.
                  text:,

                  # The type of the input item. Always `input_text`.

                  type: :input_text
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

              class InputImage < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage,
                    OpenAI::Internal::AnyHash
                  )
                end

                # An inline image encoded as a data URL.
                sig { returns(String) }
                attr_accessor :image_url

                # The type of the input item. Always `input_image`.
                sig { returns(Symbol) }
                attr_accessor :type

                # The detail level of the image to be sent to the model. One of `high`, `low`,
                # `auto`, or `original`. Defaults to `auto`.
                sig {
                  returns(
                    T.nilable(OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::OrSymbol)
                  )
                }
                attr_accessor :detail

                sig do
                  params(

                    image_url: String,

                    detail: T.nilable(
                      OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::OrSymbol
                    ),

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # An inline image encoded as a data URL.
                  image_url:,

                  # The detail level of the image to be sent to the model. One of `high`, `low`,
                  # `auto`, or `original`. Defaults to `auto`.
                  detail: nil,

                  # The type of the input item. Always `input_image`.

                  type: :input_image
                )
                end

                sig do
                  override.returns(
                    {
                      image_url: String,
                      type: Symbol,
                      detail: T.nilable(
                        OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::OrSymbol
                      )
                    }
                  )
                end
                def to_hash
                end

                # The detail level of the image to be sent to the model. One of `high`, `low`,
                # `auto`, or `original`. Defaults to `auto`.
                module Detail
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol = T.type_alias {
                    T.all(Symbol, OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail)
                  }
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  LOW = T.let(
                    :low,
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )
                  HIGH = T.let(
                    :high,
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )
                  AUTO = T.let(
                    :auto,
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )
                  ORIGINAL = T.let(
                    :original,
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )

                  sig {
                    override.returns(
                      T::Array[
                        OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                      ]
                    )
                  }
                  def self.values
                  end
                end
              end

              sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::Variants]) }
              def self.variants
              end

            end

            sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreateEvent::Item::Content::Variants]) }
            def self.variants
            end

            PartsArray = T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part],
              OpenAI::Internal::Type::Converter
            )

          end

          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionItemCreateEvent::Item::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MESSAGE = T.let(:message, OpenAI::Live::DecisionItemCreateEvent::Item::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreateEvent::Item::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

      end

    end

  end
end
