# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol
              )
            )
          end
          attr_reader :detail

          sig do
            params(
              detail: OpenAI::Beta::Threads::ImageFileDelta::Detail::OrSymbol
            ).void
          end
          attr_writer :detail

          # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          # in the message content. Set `purpose="vision"` when uploading the File if you
          # need to later display the file content.
          sig { returns(T.nilable(String)) }
          attr_reader :file_id

          sig { params(file_id: String).void }
          attr_writer :file_id

          sig do
            params(
              detail: OpenAI::Beta::Threads::ImageFileDelta::Detail::OrSymbol,
              file_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Specifies the detail level of the image if specified by the user. `low` uses
            # fewer tokens, you can opt in to high resolution using `high`.
            detail: nil,
            # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
            # in the message content. Set `purpose="vision"` when uploading the File if you
            # need to later display the file content.
            file_id: nil
          )
          end

          sig do
            override.returns(
              {
                detail:
                  OpenAI::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol,
                file_id: String
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
                T.all(Symbol, OpenAI::Beta::Threads::ImageFileDelta::Detail)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol
              )
            LOW =
              T.let(
                :low,
                OpenAI::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol
                ]
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
