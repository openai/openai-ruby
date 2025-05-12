# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Text < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(OpenAI::Beta::Threads::Text, OpenAI::Internal::AnyHash)
            end

          sig do
            returns(
              T::Array[
                T.any(
                  OpenAI::Beta::Threads::FileCitationAnnotation,
                  OpenAI::Beta::Threads::FilePathAnnotation
                )
              ]
            )
          end
          attr_accessor :annotations

          # The data that makes up the text.
          sig { returns(String) }
          attr_accessor :value

          sig do
            params(
              annotations:
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::FileCitationAnnotation::OrHash,
                    OpenAI::Beta::Threads::FilePathAnnotation::OrHash
                  )
                ],
              value: String
            ).returns(T.attached_class)
          end
          def self.new(
            annotations:,
            # The data that makes up the text.
            value:
          )
          end

          sig do
            override.returns(
              {
                annotations:
                  T::Array[
                    T.any(
                      OpenAI::Beta::Threads::FileCitationAnnotation,
                      OpenAI::Beta::Threads::FilePathAnnotation
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
