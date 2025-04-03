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
          attr_accessor :annotations

          # The data that makes up the text.
          sig { returns(String) }
          attr_accessor :value

          sig do
            params(
              annotations: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::FileCitationAnnotation,
                OpenAI::Internal::Util::AnyHash,
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
