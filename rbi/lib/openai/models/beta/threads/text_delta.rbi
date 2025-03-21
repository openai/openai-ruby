# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class TextDelta < OpenAI::BaseModel
          sig do
            returns(
              T.nilable(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
                  OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation
                )
                ]
              )
            )
          end
          attr_reader :annotations

          sig do
            params(
              annotations: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
                OpenAI::Util::AnyHash,
                OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation
              )
              ]
            )
              .void
          end
          attr_writer :annotations

          # The data that makes up the text.
          sig { returns(T.nilable(String)) }
          attr_reader :value

          sig { params(value: String).void }
          attr_writer :value

          sig do
            params(
              annotations: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
                OpenAI::Util::AnyHash,
                OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation
              )
              ],
              value: String
            )
              .returns(T.attached_class)
          end
          def self.new(annotations: nil, value: nil)
          end

          sig do
            override
              .returns(
                {
                  annotations: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
                    OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation
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
