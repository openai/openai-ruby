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
          def annotations
          end

          sig do
            params(
              _: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
                OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation
              )
              ]
            )
              .returns(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
                  OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation
                )
                ]
              )
          end
          def annotations=(_)
          end

          # The data that makes up the text.
          sig { returns(T.nilable(String)) }
          def value
          end

          sig { params(_: String).returns(String) }
          def value=(_)
          end

          sig do
            params(
              annotations: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation,
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
