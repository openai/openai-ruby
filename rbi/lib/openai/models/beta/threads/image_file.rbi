# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFile < OpenAI::Internal::Type::BaseModel
          # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          # in the message content. Set `purpose="vision"` when uploading the File if you
          # need to later display the file content.
          sig { returns(String) }
          attr_accessor :file_id

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageFile::Detail::OrSymbol)) }
          attr_reader :detail

          sig { params(detail: OpenAI::Models::Beta::Threads::ImageFile::Detail::OrSymbol).void }
          attr_writer :detail

          sig do
            params(file_id: String, detail: OpenAI::Models::Beta::Threads::ImageFile::Detail::OrSymbol)
              .returns(T.attached_class)
          end
          def self.new(file_id:, detail: nil); end

          sig { override.returns({file_id: String, detail: OpenAI::Models::Beta::Threads::ImageFile::Detail::OrSymbol}) }
          def to_hash; end

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO = T.let(:auto, OpenAI::Models::Beta::Threads::ImageFile::Detail::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Models::Beta::Threads::ImageFile::Detail::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Models::Beta::Threads::ImageFile::Detail::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::ImageFile::Detail::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end
  end
end
