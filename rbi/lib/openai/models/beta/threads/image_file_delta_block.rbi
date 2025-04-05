# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDeltaBlock < OpenAI::Internal::Type::BaseModel
          # The index of the content part in the message.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `image_file`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageFileDelta)) }
          attr_reader :image_file

          sig { params(image_file: T.any(OpenAI::Models::Beta::Threads::ImageFileDelta, OpenAI::Internal::AnyHash)).void }
          attr_writer :image_file

          # References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   in the content of a message.
          sig do
            params(
              index: Integer,
              image_file: T.any(OpenAI::Models::Beta::Threads::ImageFileDelta, OpenAI::Internal::AnyHash),
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(index:, image_file: nil, type: :image_file); end

          sig do
            override.returns({index: Integer, type: Symbol, image_file: OpenAI::Models::Beta::Threads::ImageFileDelta})
          end
          def to_hash; end
        end
      end
    end
  end
end
