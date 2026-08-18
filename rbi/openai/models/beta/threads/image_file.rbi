# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFile < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(OpenAI::Beta::Threads::ImageFile, OpenAI::Internal::AnyHash)
            end

          # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          # in the message content. Set `purpose="vision"` when uploading the File if you
          # need to later display the file content.
          sig { returns(String) }
          attr_accessor :file_id

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          sig do
            returns(
              T.nilable(OpenAI::Beta::Threads::ImageFile::Detail::OrSymbol)
            )
          end
          attr_reader :detail

          sig do
            params(
              detail: OpenAI::Beta::Threads::ImageFile::Detail::OrSymbol
            ).void
          end
          attr_writer :detail

          sig do
            params(
              file_id: String,
              detail: OpenAI::Beta::Threads::ImageFile::Detail::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
            # in the message content. Set `purpose="vision"` when uploading the File if you
            # need to later display the file content.
            file_id:,
            # Specifies the detail level of the image if specified by the user. `low` uses
            # fewer tokens, you can opt in to high resolution using `high`.
            detail: nil
          )
          end

          sig do
            override.returns(
              {
                file_id: String,
                detail: OpenAI::Beta::Threads::ImageFile::Detail::OrSymbol
              }
            )
          end
          def to_hash
          end

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::ImageFile::Detail)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::Threads::ImageFile::Detail::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Beta::Threads::ImageFile::Detail::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Beta::Threads::ImageFile::Detail::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[OpenAI::Beta::Threads::ImageFile::Detail::TaggedSymbol]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
