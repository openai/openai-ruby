# typed: strong

module OpenAI
  module Models
    class ModerationCreateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      sig do
        returns(
          T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          )
        )
      end
      def input
      end

      sig do
        params(
          _: T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          )
        )
          .returns(
            T.any(
              String,
              T::Array[String],
              T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
            )
          )
      end
      def input=(_)
      end

      sig { returns(T.nilable(T.any(String, Symbol))) }
      def model
      end

      sig { params(_: T.any(String, Symbol)).returns(T.any(String, Symbol)) }
      def model=(_)
      end

      sig do
        params(
          input: T.any(
            String,
            T::Array[String],
            T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
          ),
          model: T.any(String, Symbol),
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(input:, model: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              input: T.any(
                String,
                T::Array[String],
                T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]
              ),
              model: T.any(String, Symbol),
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      class Input < OpenAI::Union
        abstract!

        StringArray = T.type_alias { T::Array[String] }

        ModerationMultiModalInputArray = T.type_alias { T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)] }

        class << self
          sig do
            override
              .returns(
                [[NilClass, String], [NilClass, T::Array[String]], [NilClass, T::Array[T.any(OpenAI::Models::ModerationImageURLInput, OpenAI::Models::ModerationTextInput)]]]
              )
          end
          private def variants
          end
        end
      end

      class Model < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([[NilClass, String], [NilClass, Symbol]]) }
          private def variants
          end
        end
      end
    end
  end
end
