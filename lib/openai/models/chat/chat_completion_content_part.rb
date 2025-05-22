# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # Learn about
      # [text inputs](https://platform.openai.com/docs/guides/text-generation).
      module ChatCompletionContentPart
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Learn about [text inputs](https://platform.openai.com/docs/guides/text-generation).
        variant :text, -> { OpenAI::Chat::ChatCompletionContentPartText }

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant :image_url, -> { OpenAI::Chat::ChatCompletionContentPartImage }

        # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        variant :input_audio, -> { OpenAI::Chat::ChatCompletionContentPartInputAudio }

        # Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text generation.
        variant :file, -> { OpenAI::Chat::ChatCompletionContentPart::File }

        class File < OpenAI::Internal::Type::BaseModel
          # @!attribute file
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionContentPart::File::File]
          required :file, -> { OpenAI::Chat::ChatCompletionContentPart::File::File }

          # @!attribute type
          #   The type of the content part. Always `file`.
          #
          #   @return [Symbol, :file]
          required :type, const: :file

          # @!method initialize(file:, type: :file)
          #   Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text
          #   generation.
          #
          #   @param file [OpenAI::Models::Chat::ChatCompletionContentPart::File::File]
          #
          #   @param type [Symbol, :file] The type of the content part. Always `file`.

          # @see OpenAI::Models::Chat::ChatCompletionContentPart::File#file
          class File < OpenAI::Internal::Type::BaseModel
            # @!attribute file_data
            #   The base64 encoded file data, used when passing the file to the model as a
            #   string.
            #
            #   @return [String, nil]
            optional :file_data, String

            # @!attribute file_id
            #   The ID of an uploaded file to use as input.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!attribute filename
            #   The name of the file, used when passing the file to the model as a string.
            #
            #   @return [String, nil]
            optional :filename, String

            # @!method initialize(file_data: nil, file_id: nil, filename: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Chat::ChatCompletionContentPart::File::File} for more details.
            #
            #   @param file_data [String] The base64 encoded file data, used when passing the file to the model
            #
            #   @param file_id [String] The ID of an uploaded file to use as input.
            #
            #   @param filename [String] The name of the file, used when passing the file to the model as a
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio, OpenAI::Models::Chat::ChatCompletionContentPart::File)]
      end
    end

    ChatCompletionContentPart = Chat::ChatCompletionContentPart
  end
end
