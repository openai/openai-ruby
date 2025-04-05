# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputImage < OpenAI::Internal::Type::BaseModel
        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        sig { returns(OpenAI::Models::Responses::ResponseInputImage::Detail::OrSymbol) }
        attr_accessor :detail

        # The type of the input item. Always `input_image`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        attr_accessor :file_id

        # The URL of the image to be sent to the model. A fully qualified URL or base64
        #   encoded image in a data URL.
        sig { returns(T.nilable(String)) }
        attr_accessor :image_url

        # An image input to the model. Learn about
        #   [image inputs](https://platform.openai.com/docs/guides/vision).
        sig do
          params(
            detail: OpenAI::Models::Responses::ResponseInputImage::Detail::OrSymbol,
            file_id: T.nilable(String),
            image_url: T.nilable(String),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(detail:, file_id: nil, image_url: nil, type: :input_image); end

        sig do
          override
            .returns(
              {
                detail: OpenAI::Models::Responses::ResponseInputImage::Detail::OrSymbol,
                type: Symbol,
                file_id: T.nilable(String),
                image_url: T.nilable(String)
              }
            )
        end
        def to_hash; end

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        module Detail
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputImage::Detail) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol) }

          HIGH = T.let(:high, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol)
          LOW = T.let(:low, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol)
          AUTO = T.let(:auto, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
