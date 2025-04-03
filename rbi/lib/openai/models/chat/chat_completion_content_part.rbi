# typed: strong

module OpenAI
  module Models
    module Chat
      # Learn about
      #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
      module ChatCompletionContentPart
        extend OpenAI::Union

        class File < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Chat::ChatCompletionContentPart::File::File) }
          attr_reader :file

          sig do
            params(
              file: T.any(OpenAI::Models::Chat::ChatCompletionContentPart::File::File, OpenAI::Internal::Util::AnyHash)
            )
              .void
          end
          attr_writer :file

          # The type of the content part. Always `file`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text
          #   generation.
          sig do
            params(
              file: T.any(OpenAI::Models::Chat::ChatCompletionContentPart::File::File, OpenAI::Internal::Util::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(file:, type: :file)
          end

          sig { override.returns({file: OpenAI::Models::Chat::ChatCompletionContentPart::File::File, type: Symbol}) }
          def to_hash
          end

          class File < OpenAI::BaseModel
            # The base64 encoded file data, used when passing the file to the model as a
            #   string.
            sig { returns(T.nilable(String)) }
            attr_reader :file_data

            sig { params(file_data: String).void }
            attr_writer :file_data

            # The ID of an uploaded file to use as input.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            # The name of the file, used when passing the file to the model as a string.
            sig { returns(T.nilable(String)) }
            attr_reader :filename

            sig { params(filename: String).void }
            attr_writer :filename

            sig { params(file_data: String, file_id: String, filename: String).returns(T.attached_class) }
            def self.new(file_data: nil, file_id: nil, filename: nil)
            end

            sig { override.returns({file_data: String, file_id: String, filename: String}) }
            def to_hash
            end
          end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::Chat::ChatCompletionContentPartText, OpenAI::Models::Chat::ChatCompletionContentPartImage, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio, OpenAI::Models::Chat::ChatCompletionContentPart::File]
            )
        end
        def self.variants
        end
      end
    end

    ChatCompletionContentPart = Chat::ChatCompletionContentPart
  end
end
