# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionItemCreatedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionItemCreatedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        sig { returns(OpenAI::Live::DecisionItemCreatedEvent::Item) }
        attr_reader :item

        sig { params(item: OpenAI::Live::DecisionItemCreatedEvent::Item::OrHash).void }
        attr_writer :item

        sig { returns(Symbol) }
        attr_accessor :type

        # The event_id of the client command associated with this server event, when
        # supplied.
        sig { returns(T.nilable(String)) }
        attr_reader :client_event_id

        sig { params(client_event_id: String).void }
        attr_writer :client_event_id

        # An input item was appended for future decisions.
        sig do
          params(

            event_id: String,

            item: OpenAI::Live::DecisionItemCreatedEvent::Item::OrHash,

            client_event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the Live server event.
          event_id:,

          item:,

          # The event_id of the client command associated with this server event, when
          # supplied.
          client_event_id: nil,

          type: :"decision.item.created"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item: OpenAI::Live::DecisionItemCreatedEvent::Item,
              type: Symbol,
              client_event_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        class Item < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DecisionItemCreatedEvent::Item,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the stored Decision input item.
          sig { returns(String) }
          attr_accessor :id

          # The text input to the model.
          sig { returns(OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Variants) }
          attr_accessor :content

          # The message role. Always `user`.
          sig { returns(Symbol) }
          attr_accessor :role

          sig { returns(T.nilable(OpenAI::Live::DecisionItemCreatedEvent::Item::Type::OrSymbol)) }
          attr_reader :type

          sig { params(type: OpenAI::Live::DecisionItemCreatedEvent::Item::Type::OrSymbol).void }
          attr_writer :type

          sig do
            params(

              id: String,

              content: OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Variants,

              type: OpenAI::Live::DecisionItemCreatedEvent::Item::Type::OrSymbol,

              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the stored Decision input item.
            id:,

            # The text input to the model.
            content:,

            type: nil,

            # The message role. Always `user`.

            role: :user
          )
          end

          sig do
            override.returns(
              {
                id: String,
                content: OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Variants,
                role: Symbol,
                type: T.nilable(OpenAI::Live::DecisionItemCreatedEvent::Item::Type::OrSymbol)
              }
            )
          end
          def to_hash
          end

          # The text input to the model.
          module Content
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(String, T::Array[OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::Variants])
            }

            module Part
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText,
                  OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage
                )
              }

              class InputText < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText,
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
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage,
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
                    T.nilable(OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::OrSymbol)
                  )
                }
                attr_accessor :detail

                sig do
                  params(

                    image_url: String,

                    detail: T.nilable(
                      OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::OrSymbol
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
                        OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::OrSymbol
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
                    T.all(Symbol, OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail)
                  }
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  LOW = T.let(
                    :low,
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )
                  HIGH = T.let(
                    :high,
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )
                  AUTO = T.let(
                    :auto,
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )
                  ORIGINAL = T.let(
                    :original,
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                  )

                  sig {
                    override.returns(
                      T::Array[
                        OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail::TaggedSymbol
                      ]
                    )
                  }
                  def self.values
                  end
                end
              end

              sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::Variants]) }
              def self.variants
              end

            end

            sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Variants]) }
            def self.variants
            end

            PartsArray = T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part],
              OpenAI::Internal::Type::Converter
            )

          end

          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionItemCreatedEvent::Item::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MESSAGE = T.let(:message, OpenAI::Live::DecisionItemCreatedEvent::Item::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Live::DecisionItemCreatedEvent::Item::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

      end

    end

  end
end
