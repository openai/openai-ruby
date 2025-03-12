# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Text < OpenAI::BaseModel
          sig do
            returns(
              T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                OpenAI::Models::Beta::Threads::FilePathAnnotation
              )
              ]
            )
          end
          def annotations
          end

          sig do
            params(
              _: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                OpenAI::Models::Beta::Threads::FilePathAnnotation
              )
              ]
            )
              .returns(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                  OpenAI::Models::Beta::Threads::FilePathAnnotation
                )
                ]
              )
          end
          def annotations=(_)
          end

          sig { returns(String) }
          def value
          end

          sig { params(_: String).returns(String) }
          def value=(_)
          end

          sig do
            params(
              annotations: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                OpenAI::Models::Beta::Threads::FilePathAnnotation
              )
              ],
              value: String
            )
              .returns(T.attached_class)
          end
          def self.new(annotations:, value:)
          end

          sig do
            override
              .returns(
                {
                  annotations: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                    OpenAI::Models::Beta::Threads::FilePathAnnotation
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
