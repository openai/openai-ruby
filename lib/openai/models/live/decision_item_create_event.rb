# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionItemCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #
        #   @return [OpenAI::Models::Live::DecisionItemCreateEvent::Item]
        required :item, -> { OpenAI::Live::DecisionItemCreateEvent::Item }

        # @!attribute type
        #
        #   @return [Symbol, :"decision.item.create"]
        required :type, const: :"decision.item.create"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(item:, event_id: nil, type: :"decision.item.create")
        #   Append an input item for future decisions without starting an evaluation or
        #   changing Live voice context.
        #
        #   @param item [OpenAI::Models::Live::DecisionItemCreateEvent::Item]
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"decision.item.create"]

        # @see OpenAI::Models::Live::DecisionItemCreateEvent#item
        class Item < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #   The text input to the model.
          #
          #   @return [String, Array<OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage>]
          required :content, union: -> { OpenAI::Live::DecisionItemCreateEvent::Item::Content }

          # @!attribute role
          #   The message role. Always `user`.
          #
          #   @return [Symbol, :user]
          required :role, const: :user

          # @!attribute id
          #   The unique ID of this message item.
          #
          #   @return [String, nil]
          optional :id, String, nil?: true

          # @!attribute type
          #
          #   @return [Symbol, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Type, nil]
          optional :type, enum: -> { OpenAI::Live::DecisionItemCreateEvent::Item::Type }

          # @!method initialize(content:, id: nil, type: nil, role: :user)
          #   @param content [String, Array<OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage>]
          #     The text input to the model.
          #
          #   @param id [String, nil]
          #     The unique ID of this message item.
          #
          #   @param type [Symbol, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Type]
          #
          #   @param role [Symbol, :user]
          #     The message role. Always `user`.

          # The text input to the model.
          #
          # @see OpenAI::Models::Live::DecisionItemCreateEvent::Item#content
          module Content
            extend OpenAI::Internal::Type::Union

            # The text input to the model.
            variant String

            variant -> { OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::PartsArray }

            module Part
              extend OpenAI::Internal::Type::Union

              discriminator :type

              variant :input_text, -> { OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputText }

              variant :input_image, -> { OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage }

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
                #   @return [Symbol, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail, nil]
                optional(
                  :detail,
                  enum: -> {
                    OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail
                  },
                  nil?: true
                )

                # @!method initialize(image_url:, detail: nil, type: :input_image)
                #   @param image_url [String]
                #     An inline image encoded as a data URL.
                #
                #   @param detail [Symbol, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage::Detail, nil]
                #     The detail level of the image to be sent to the model. One of `high`, `low`,
                #     `auto`, or `original`. Defaults to `auto`.
                #
                #   @param type [Symbol, :input_image]
                #     The type of the input item. Always `input_image`.

                # The detail level of the image to be sent to the model. One of `high`, `low`,
                # `auto`, or `original`. Defaults to `auto`.
                #
                # @see OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage#detail
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
              #   @return [Array(OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage)]
            end

            # @!method self.variants
            #   @return [Array(String, Array<OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputText, OpenAI::Models::Live::DecisionItemCreateEvent::Item::Content::Part::InputImage>)]

            # @type [OpenAI::Internal::Type::Converter]
            PartsArray = OpenAI::Internal::Type::ArrayOf[
              union: -> { OpenAI::Live::DecisionItemCreateEvent::Item::Content::Part }
            ]
          end

          # @see OpenAI::Models::Live::DecisionItemCreateEvent::Item#type
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
