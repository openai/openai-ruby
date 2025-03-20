# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLDelta < OpenAI::BaseModel
          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol)) }
          def detail
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol)
              .returns(OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol)
          end
          def detail=(_)
          end

          # The URL of the image, must be a supported image types: jpeg, jpg, png, gif,
          #   webp.
          sig { returns(T.nilable(String)) }
          def url
          end

          sig { params(_: String).returns(String) }
          def url=(_)
          end

          sig do
            params(detail: OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol, url: String)
              .returns(T.attached_class)
          end
          def self.new(detail: nil, url: nil)
          end

          sig do
            override.returns({detail: OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol, url: String})
          end
          def to_hash
          end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`.
          module Detail
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail) }
            OrSymbol =
              T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol) }

            AUTO = T.let(:auto, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Models::Beta::Threads::ImageURLDelta::Detail::TaggedSymbol)
          end
        end
      end
    end
  end
end
