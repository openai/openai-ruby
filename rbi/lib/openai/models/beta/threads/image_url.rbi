# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURL < OpenAI::Internal::Type::BaseModel
          # The external URL of the image, must be a supported image types: jpeg, jpg, png,
          #   gif, webp.
          sig { returns(String) }
          attr_accessor :url

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`. Default value is `auto`
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::ImageURL::Detail::OrSymbol)) }
          attr_reader :detail

          sig { params(detail: OpenAI::Models::Beta::Threads::ImageURL::Detail::OrSymbol).void }
          attr_writer :detail

          sig do
            params(url: String, detail: OpenAI::Models::Beta::Threads::ImageURL::Detail::OrSymbol)
              .returns(T.attached_class)
          end
          def self.new(url:, detail: nil); end

          sig { override.returns({url: String, detail: OpenAI::Models::Beta::Threads::ImageURL::Detail::OrSymbol}) }
          def to_hash; end

          # Specifies the detail level of the image. `low` uses fewer tokens, you can opt in
          #   to high resolution using `high`. Default value is `auto`
          module Detail
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::ImageURL::Detail) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::Threads::ImageURL::Detail::TaggedSymbol) }

            AUTO = T.let(:auto, OpenAI::Models::Beta::Threads::ImageURL::Detail::TaggedSymbol)
            LOW = T.let(:low, OpenAI::Models::Beta::Threads::ImageURL::Detail::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Models::Beta::Threads::ImageURL::Detail::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::ImageURL::Detail::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end
  end
end
