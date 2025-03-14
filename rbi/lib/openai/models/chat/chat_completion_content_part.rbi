# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPart = T.type_alias { Chat::ChatCompletionContentPart }

    module Chat
      # Learn about
      #   [text inputs](https://platform.openai.com/docs/guides/text-generation).
      class ChatCompletionContentPart < OpenAI::Union
        abstract!

        class File < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Chat::ChatCompletionContentPart::File::File) }
          def file
          end

          sig do
            params(_: OpenAI::Models::Chat::ChatCompletionContentPart::File::File)
              .returns(OpenAI::Models::Chat::ChatCompletionContentPart::File::File)
          end
          def file=(_)
          end

          # The type of the content part. Always `file`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text
          #   generation.
          sig do
            params(file: OpenAI::Models::Chat::ChatCompletionContentPart::File::File, type: Symbol)
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
            def file_data
            end

            sig { params(_: String).returns(String) }
            def file_data=(_)
            end

            # The ID of an uploaded file to use as input.
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            # The name of the file, used when passing the file to the model as a string.
            sig { returns(T.nilable(String)) }
            def file_name
            end

            sig { params(_: String).returns(String) }
            def file_name=(_)
            end

            sig { params(file_data: String, file_id: String, file_name: String).returns(T.attached_class) }
            def self.new(file_data: nil, file_id: nil, file_name: nil)
            end

            sig { override.returns({file_data: String, file_id: String, file_name: String}) }
            def to_hash
            end
          end
        end

        class << self
          # @api private
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Chat::ChatCompletionContentPartText], [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartImage], [Symbol, OpenAI::Models::Chat::ChatCompletionContentPartInputAudio], [Symbol, OpenAI::Models::Chat::ChatCompletionContentPart::File]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
