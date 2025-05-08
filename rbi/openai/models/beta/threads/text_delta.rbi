# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig do
            returns(
              T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::FileCitationDeltaAnnotation,
                    OpenAI::Beta::Threads::FilePathDeltaAnnotation
                  )
                ]
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
                  T::Array[
                    T.any(
                      OpenAI::Beta::Threads::FileCitationDeltaAnnotation,
                      OpenAI::Beta::Threads::FilePathDeltaAnnotation
                    )
                  ],
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
