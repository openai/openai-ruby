# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionUserMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The text input to the model.
        #
        #   @return [String, Array<OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputText, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputJSON>]
        required :content, union: -> { OpenAI::Live::DecisionUserMessage::Content }

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
        #   @return [Symbol, OpenAI::Models::Live::DecisionUserMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Live::DecisionUserMessage::Type }

        # @!method initialize(content:, id: nil, type: nil, role: :user)
        #   @param content [String, Array<OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputText, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputJSON>]
        #     The text input to the model.
        #
        #   @param id [String, nil]
        #     The unique ID of this message item.
        #
        #   @param type [Symbol, OpenAI::Models::Live::DecisionUserMessage::Type]
        #
        #   @param role [Symbol, :user]
        #     The message role. Always `user`.

        # The text input to the model.
        #
        # @see OpenAI::Models::Live::DecisionUserMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text input to the model.
          variant String

          variant -> { OpenAI::Models::Live::DecisionUserMessage::Content::PartsArray }

          module Part
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :input_text, -> { OpenAI::Live::DecisionUserMessage::Content::Part::InputText }

            variant :input_image, -> { OpenAI::Live::DecisionUserMessage::Content::Part::InputImage }

            variant :input_json, -> { OpenAI::Live::DecisionUserMessage::Content::Part::InputJSON }

            class InputText < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #   The text input to the model.
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #
              #   @return [Symbol, :input_text]
              required :type, const: :input_text

              # @!method initialize(text:, type: :input_text)
              #   @param text [String]
              #     The text input to the model.
              #
              #   @param type [Symbol, :input_text]
            end

            class InputImage < OpenAI::Internal::Type::BaseModel
              # @!attribute image_url
              #   A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
              #
              #   @return [String]
              required :image_url, String

              # @!attribute type
              #
              #   @return [Symbol, :input_image]
              required :type, const: :input_image

              # @!attribute detail
              #   The detail level of the image to be sent to the model. One of `high`, `low`,
              #   `auto`, or `original`. Defaults to `auto`.
              #
              #   @return [Symbol, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage::Detail, nil]
              optional(
                :detail,
                enum: -> { OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail },
                nil?: true
              )

              # @!method initialize(image_url:, detail: nil, type: :input_image)
              #   @param image_url [String]
              #     A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
              #
              #   @param detail [Symbol, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage::Detail, nil]
              #     The detail level of the image to be sent to the model. One of `high`, `low`,
              #     `auto`, or `original`. Defaults to `auto`.
              #
              #   @param type [Symbol, :input_image]

              # The detail level of the image to be sent to the model. One of `high`, `low`,
              # `auto`, or `original`. Defaults to `auto`.
              #
              # @see OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage#detail
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

            class InputJSON < OpenAI::Internal::Type::BaseModel
              # @!attribute data
              #
              #   @return [Hash{Symbol=>Object}, Array<Hash{Symbol=>Object}>]
              required :data, union: -> { OpenAI::Live::DecisionUserMessage::Content::Part::InputJSON::Data }

              # @!attribute type
              #
              #   @return [Symbol, :input_json]
              required :type, const: :input_json

              # @!method initialize(data:, type: :input_json)
              #   @param data [Hash{Symbol=>Object}, Array<Hash{Symbol=>Object}>]
              #   @param type [Symbol, :input_json]

              # @see OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputJSON#data
              module Data
                extend OpenAI::Internal::Type::Union

                variant OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

                variant(
                  -> {
                    OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputJSON::Data::DecisionJSONObjectArray
                  }
                )

                # @!method self.variants
                #   @return [Array(Hash{Symbol=>Object}, Array<Hash{Symbol=>Object}>)]

                # @type [OpenAI::Internal::Type::Converter]
                DecisionJSONObjectArray = OpenAI::Internal::Type::ArrayOf[
                  OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]
                ]
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputText, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputJSON)]
          end

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputText, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputImage, OpenAI::Models::Live::DecisionUserMessage::Content::Part::InputJSON>)]

          # @type [OpenAI::Internal::Type::Converter]
          PartsArray = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::Live::DecisionUserMessage::Content::Part }]
        end

        # @see OpenAI::Models::Live::DecisionUserMessage#type
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
