# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDelta < OpenAI::BaseModel
          # Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol)) }
          attr_reader :detail

          sig { params(detail: OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::OrSymbol).void }
          attr_writer :detail

          # The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          #   in the message content. Set `purpose="vision"` when uploading the File if you
          #   need to later display the file content.
          sig { returns(T.nilable(String)) }
          attr_reader :file_id

          sig { params(file_id: String).void }
          attr_writer :file_id

          sig do
            params(detail: OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::OrSymbol, file_id: String)
              .returns(T.attached_class)
          end
          def self.new(detail: nil, file_id: nil)
          end

          sig do
            override
              .returns({detail: OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol, file_id: String})
          end
          def to_hash
          end

          # Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          module Detail
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol) }

            AUTO = T.let(:auto, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::ImageFileDelta::Detail::TaggedSymbol]) }
            def self.values
            end
          end
        end
      end
    end
  end
end
