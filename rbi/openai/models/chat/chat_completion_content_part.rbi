# typed: strong

module OpenAI
  module Models
    ChatCompletionContentPart = Chat::ChatCompletionContentPart

    module Chat
      # Learn about
      # [text inputs](https://platform.openai.com/docs/guides/text-generation).
      module ChatCompletionContentPart
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionContentPartText,
              OpenAI::Chat::ChatCompletionContentPartImage,
              OpenAI::Chat::ChatCompletionContentPartInputAudio,
              OpenAI::Chat::ChatCompletionContentPart::File
            )
          end

        class File < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionContentPart::File,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(OpenAI::Chat::ChatCompletionContentPart::File::File) }
          attr_reader :file

          sig do
            params(
              file: OpenAI::Chat::ChatCompletionContentPart::File::File::OrHash
            ).void
          end
          attr_writer :file

          # The type of the content part. Always `file`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
          # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
          # token block.
          sig do
            returns(
              T.nilable(
                OpenAI::Chat::ChatCompletionContentPart::File::PromptCacheBreakpoint
              )
            )
          end
          attr_reader :prompt_cache_breakpoint

          sig do
            params(
              prompt_cache_breakpoint:
                OpenAI::Chat::ChatCompletionContentPart::File::PromptCacheBreakpoint::OrHash
            ).void
          end
          attr_writer :prompt_cache_breakpoint

          # Learn about [file inputs](https://platform.openai.com/docs/guides/text) for text
          # generation.
          sig do
            params(
              file: OpenAI::Chat::ChatCompletionContentPart::File::File::OrHash,
              prompt_cache_breakpoint:
                OpenAI::Chat::ChatCompletionContentPart::File::PromptCacheBreakpoint::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            file:,
            # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
            # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
            # token block.
            prompt_cache_breakpoint: nil,
            # The type of the content part. Always `file`.
            type: :file
          )
          end

          sig do
            override.returns(
              {
                file: OpenAI::Chat::ChatCompletionContentPart::File::File,
                type: Symbol,
                prompt_cache_breakpoint:
                  OpenAI::Chat::ChatCompletionContentPart::File::PromptCacheBreakpoint
              }
            )
          end
          def to_hash
          end

          class File < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Chat::ChatCompletionContentPart::File::File,
                  OpenAI::Internal::AnyHash
                )
              end

            # The base64 encoded file data, used when passing the file to the model as a
            # string.
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

            sig do
              params(
                file_data: String,
                file_id: String,
                filename: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The base64 encoded file data, used when passing the file to the model as a
              # string.
              file_data: nil,
              # The ID of an uploaded file to use as input.
              file_id: nil,
              # The name of the file, used when passing the file to the model as a string.
              filename: nil
            )
            end

            sig do
              override.returns(
                { file_data: String, file_id: String, filename: String }
              )
            end
            def to_hash
            end
          end

          class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Chat::ChatCompletionContentPart::File::PromptCacheBreakpoint,
                  OpenAI::Internal::AnyHash
                )
              end

            # The breakpoint mode. Always `explicit`.
            sig { returns(Symbol) }
            attr_accessor :mode

            # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
            # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
            # token block.
            sig { params(mode: Symbol).returns(T.attached_class) }
            def self.new(
              # The breakpoint mode. Always `explicit`.
              mode: :explicit
            )
            end

            sig { override.returns({ mode: Symbol }) }
            def to_hash
            end
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Chat::ChatCompletionContentPart::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
