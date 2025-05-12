# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDeltaBlock < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Threads::ImageFileDeltaBlock,
                OpenAI::Internal::AnyHash
              )
            end

          # The index of the content part in the message.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `image_file`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(OpenAI::Beta::Threads::ImageFileDelta)) }
          attr_reader :image_file

          sig do
            params(
              image_file: OpenAI::Beta::Threads::ImageFileDelta::OrHash
            ).void
          end
          attr_writer :image_file

          # References an image [File](https://platform.openai.com/docs/api-reference/files)
          # in the content of a message.
          sig do
            params(
              index: Integer,
              image_file: OpenAI::Beta::Threads::ImageFileDelta::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part in the message.
            index:,
            image_file: nil,
            # Always `image_file`.
            type: :image_file
          )
          end

          sig do
            override.returns(
              {
                index: Integer,
                type: Symbol,
                image_file: OpenAI::Beta::Threads::ImageFileDelta
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
