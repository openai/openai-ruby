# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionItemCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item
        #
        #   @return [OpenAI::Models::Live::DecisionItemCreatedEvent::Item]
        required :item, -> { OpenAI::Live::DecisionItemCreatedEvent::Item }

        # @!attribute type
        #
        #   @return [Symbol, :"decision.item.created"]
        required :type, const: :"decision.item.created"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, item:, client_event_id: nil, type: :"decision.item.created")
        #   An input item was appended for future decisions.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param item [OpenAI::Models::Live::DecisionItemCreatedEvent::Item]
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"decision.item.created"]

        # @see OpenAI::Models::Live::DecisionItemCreatedEvent#item
        class Item < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the stored Decision input item.
          #
          #   @return [String]
          required :id, String

          # @!attribute content
          #   The text input to the model.
          #
          #   @return [String, Array<OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage>]
          required :content, union: -> { OpenAI::Live::DecisionItemCreatedEvent::Item::Content }

          # @!attribute role
          #   The message role. Always `user`.
          #
          #   @return [Symbol, :user]
          required :role, const: :user

          # @!attribute type
          #
          #   @return [Symbol, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Type, nil]
          optional :type, enum: -> { OpenAI::Live::DecisionItemCreatedEvent::Item::Type }

          # @!method initialize(id:, content:, type: nil, role: :user)
          #   @param id [String]
          #     The ID of the stored Decision input item.
          #
          #   @param content [String, Array<OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage>]
          #     The text input to the model.
          #
          #   @param type [Symbol, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Type]
          #
          #   @param role [Symbol, :user]
          #     The message role. Always `user`.

          # The text input to the model.
          #
          # @see OpenAI::Models::Live::DecisionItemCreatedEvent::Item#content
          module Content
            extend OpenAI::Internal::Type::Union

            # The text input to the model.
            variant String

            variant -> { OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::PartsArray }

            module Part
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :input_text, -> { OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText }

              variant :input_image, -> { OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage }

              class InputText < OpenAI::Internal::Type::BaseModel
                # @!attribute text
                #   The text input to the model.
                #
                #   @return [String]
                required :text, String

                # @!attribute type
                #   The type of the input item. Always `input_text`.
                #
                #   @return [Symbol, :input_text]
                required :type, const: :input_text

                # @!method initialize(text:, type: :input_text)
                #   @param text [String]
                #     The text input to the model.
                #
                #   @param type [Symbol, :input_text]
                #     The type of the input item. Always `input_text`.
              end

              class InputImage < OpenAI::Internal::Type::BaseModel
                # @!attribute image_url
                #   An inline image encoded as a data URL.
                #
                #   @return [String]
                required :image_url, String

                # @!attribute type
                #   The type of the input item. Always `input_image`.
                #
                #   @return [Symbol, :input_image]
                required :type, const: :input_image

                # @!attribute detail
                #   The detail level of the image to be sent to the model. One of `high`, `low`,
                #   `auto`, or `original`. Defaults to `auto`.
                #
                #   @return [Symbol, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail, nil]
                optional(
                  :detail,
                  enum: -> {
                    OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail
                  },
                  nil?: true
                )

                # @!method initialize(image_url:, detail: nil, type: :input_image)
                #   @param image_url [String]
                #     An inline image encoded as a data URL.
                #
                #   @param detail [Symbol, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage::Detail, nil]
                #     The detail level of the image to be sent to the model. One of `high`, `low`,
                #     `auto`, or `original`. Defaults to `auto`.
                #
                #   @param type [Symbol, :input_image]
                #     The type of the input item. Always `input_image`.

                # The detail level of the image to be sent to the model. One of `high`, `low`,
                # `auto`, or `original`. Defaults to `auto`.
                #
                # @see OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage#detail
                module Detail
                  extend OpenAI::Internal::Type::Enum

                  LOW = :low
                  HIGH = :high
                  AUTO = :auto
                  ORIGINAL = :original

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage)]
            end

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreatedEvent::Item::Content::Part::InputImage>)]

            # @type [OpenAI::Internal::Type::Converter]
            PartsArray = OpenAI::Internal::Type::ArrayOf[
              union: -> { OpenAI::Live::DecisionItemCreatedEvent::Item::Content::Part }
            ]
          end

          # @see OpenAI::Models::Live::DecisionItemCreatedEvent::Item#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
