# typed: strong

module OpenAI
  module Models
    module Graders
      # A single content item: input text, output text, input image, or input audio.
      module GraderInputItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              String,
              OpenAI::Responses::ResponseInputText,
              OpenAI::Graders::GraderInputItem::OutputText,
              OpenAI::Graders::GraderInputItem::InputImage,
              OpenAI::Responses::ResponseInputAudio
            )
          end

        class OutputText < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Graders::GraderInputItem::OutputText,
                OpenAI::Internal::AnyHash
              )
            end

          # The text output from the model.
          sig { returns(String) }
          attr_accessor :text

          # The type of the output text. Always `output_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A text output from the model.
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(
            # The text output from the model.
            text:,
            # The type of the output text. Always `output_text`.
            type: :output_text
          )
          end

          sig { override.returns({ text: String, type: Symbol }) }
          def to_hash
          end
        end

        class InputImage < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Graders::GraderInputItem::InputImage,
                OpenAI::Internal::AnyHash
              )
            end

          # The URL of the image input.
          sig { returns(String) }
          attr_accessor :image_url

          # The type of the image input. Always `input_image`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The detail level of the image to be sent to the model. One of `high`, `low`, or
          # `auto`. Defaults to `auto`.
          sig { returns(T.nilable(String)) }
          attr_reader :detail

          sig { params(detail: String).void }
          attr_writer :detail

          # An image input block used within EvalItem content arrays.
          sig do
            params(image_url: String, detail: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # The URL of the image input.
            image_url:,
            # The detail level of the image to be sent to the model. One of `high`, `low`, or
            # `auto`. Defaults to `auto`.
            detail: nil,
            # The type of the image input. Always `input_image`.
            type: :input_image
          )
          end

          sig do
            override.returns(
              { image_url: String, type: Symbol, detail: String }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(T::Array[OpenAI::Graders::GraderInputItem::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
