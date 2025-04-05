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
        variant :text, -> { OpenAI::Models::Chat::ChatCompletionContentPartText }

        # Learn about [image inputs](https://platform.openai.com/docs/guides/vision).
        variant :image_url, -> { OpenAI::Models::Chat::ChatCompletionContentPartImage }

        # Learn about [audio inputs](https://platform.openai.com/docs/guides/audio).
        variant :input_audio, -> { OpenAI::Models::Chat::ChatCompletionContentPartInputAudio }

        # Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text generation.
        variant :file, -> { OpenAI::Models::Chat::ChatCompletionContentPart::File }

        class File < OpenAI::Internal::Type::BaseModel
          # @!attribute file
          #
          #   @return [OpenAI::Models::Chat::ChatCompletionContentPart::File::File]
          required :file, -> { OpenAI::Models::Chat::ChatCompletionContentPart::File::File }

          # @!attribute type
          #   The type of the content part. Always `file`.
          #
          #   @return [Symbol, :file]
          required :type, const: :file

          # @!parse
          #   # Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text
          #   # generation.
          #   #
          #   # @param file [OpenAI::Models::Chat::ChatCompletionContentPart::File::File]
          #   # @param type [Symbol, :file]
          #   #
          #   def initialize(file:, type: :file, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Chat::ChatCompletionContentPart::File#file
          class File < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] file_data
            #   The base64 encoded file data, used when passing the file to the model as a
            #   string.
            #
            #   @return [String, nil]
            optional :file_data, String

            # @!parse
            #   # @return [String]
            #   attr_writer :file_data

            # @!attribute [r] file_id
            #   The ID of an uploaded file to use as input.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :file_id

            # @!attribute [r] filename
            #   The name of the file, used when passing the file to the model as a string.
            #
            #   @return [String, nil]
            optional :filename, String

            # @!parse
            #   # @return [String]
            #   attr_writer :filename

            # @!parse
            #   # @param file_data [String]
            #   # @param file_id [String]
            #   # @param filename [String]
            #   #
            #   def initialize(file_data: nil, file_id: nil, filename: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end
        end

        # @!parse
        #   # @return [Array(OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio, OpenAI::Models::Chat::ChatCompletionContentPart::File)]
        #   def self.variants; end
      end
    end

    ChatCompletionContentPart = Chat::ChatCompletionContentPart
  end
end
