# typed: strong

module OpenAI
  module Models

    module Beta

      module Threads

        class FileCitationAnnotation < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Threads::FileCitationAnnotation,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(Integer) }
          attr_accessor :end_index

          sig { returns(OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation) }
          attr_reader :file_citation

          sig { params(file_citation: OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation::OrHash).void }
          attr_writer :file_citation

          sig { returns(Integer) }
          attr_accessor :start_index

          # The text in the message content that needs to be replaced.
          sig { returns(String) }
          attr_accessor :text

          # Always `file_citation`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A citation within the message that points to a specific quote from a specific
          # File associated with the assistant or the message. Generated when the assistant
          # uses the "file_search" tool to search files.
          sig do
            params(

              end_index: Integer,

              file_citation: OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation::OrHash,

              start_index: Integer,

              text: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            end_index:,

            file_citation:,

            start_index:,

            # The text in the message content that needs to be replaced.
            text:,

            # Always `file_citation`.

            type: :file_citation
          )
          end

          sig do
            override.returns(
              {
                end_index: Integer,
                file_citation: OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation,
                start_index: Integer,
                text: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class FileCitation < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the specific File the citation is from.
            sig { returns(String) }
            attr_accessor :file_id

            sig do
              params(

                file_id: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the specific File the citation is from.

              file_id:
            )
            end

            sig do
              override.returns(
                {file_id: String}
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
