# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputImage < OpenAI::BaseModel
        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        sig { returns(OpenAI::Models::Responses::ResponseInputImage::Detail::OrSymbol) }
        def detail
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseInputImage::Detail::OrSymbol)
            .returns(OpenAI::Models::Responses::ResponseInputImage::Detail::OrSymbol)
        end
        def detail=(_)
        end

        # The type of the input item. Always `input_image`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The ID of the file to be sent to the model.
        sig { returns(T.nilable(String)) }
        def file_id
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def file_id=(_)
        end

        # The URL of the image to be sent to the model. A fully qualified URL or base64
        #   encoded image in a data URL.
        sig { returns(T.nilable(String)) }
        def image_url
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def image_url=(_)
        end

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
        def self.new(detail:, file_id: nil, image_url: nil, type: :input_image)
        end

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
        def to_hash
        end

        # The detail level of the image to be sent to the model. One of `high`, `low`, or
        #   `auto`. Defaults to `auto`.
        module Detail
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputImage::Detail) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol) }

          HIGH = T.let(:high, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol)
          LOW = T.let(:low, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol)
          AUTO = T.let(:auto, OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputImage::Detail::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
