# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(OpenAI::Beta::Threads::TextDelta, OpenAI::Internal::AnyHash)
            end

          sig do
            returns(
              T.nilable(
                T::Array[OpenAI::Beta::Threads::AnnotationDelta::Variants]
              )
            )
          end
          attr_reader :annotations

          sig do
            params(
              annotations:
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::FileCitationDeltaAnnotation::OrHash,
                    OpenAI::Beta::Threads::FilePathDeltaAnnotation::OrHash
                  )
                ]
            ).void
          end
          attr_writer :annotations

          # The data that makes up the text.
          sig { returns(T.nilable(String)) }
          attr_reader :value

          sig { params(value: String).void }
          attr_writer :value

          sig do
            params(
              annotations:
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::FileCitationDeltaAnnotation::OrHash,
                    OpenAI::Beta::Threads::FilePathDeltaAnnotation::OrHash
                  )
                ],
              value: String
            ).returns(T.attached_class)
          end
          def self.new(
            annotations: nil,
            # The data that makes up the text.
            value: nil
          )
          end

          sig do
            override.returns(
              {
                annotations:
                  T::Array[OpenAI::Beta::Threads::AnnotationDelta::Variants],
                value: String
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
