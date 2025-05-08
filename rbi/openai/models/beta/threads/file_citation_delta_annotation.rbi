# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FileCitationDeltaAnnotation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The index of the annotation in the text content part.
          sig { returns(Integer) }
          attr_accessor :index

          # Always `file_citation`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(Integer)) }
          attr_reader :end_index

          sig { params(end_index: Integer).void }
          attr_writer :end_index

          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Threads::FileCitationDeltaAnnotation::FileCitation
              )
            )
          end
          attr_reader :file_citation

          sig do
            params(
              file_citation:
                OpenAI::Beta::Threads::FileCitationDeltaAnnotation::FileCitation::OrHash
            ).void
          end
          attr_writer :file_citation

          sig { returns(T.nilable(Integer)) }
          attr_reader :start_index

          sig { params(start_index: Integer).void }
          attr_writer :start_index

          # The text in the message content that needs to be replaced.
          sig { returns(T.nilable(String)) }
          attr_reader :text

          sig { params(text: String).void }
          attr_writer :text

          # A citation within the message that points to a specific quote from a specific
          # File associated with the assistant or the message. Generated when the assistant
          # uses the "file_search" tool to search files.
          sig do
            params(
              index: Integer,
              end_index: Integer,
              file_citation:
                OpenAI::Beta::Threads::FileCitationDeltaAnnotation::FileCitation::OrHash,
              start_index: Integer,
              text: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the annotation in the text content part.
            index:,
            end_index: nil,
            file_citation: nil,
            start_index: nil,
            # The text in the message content that needs to be replaced.
            text: nil,
            # Always `file_citation`.
            type: :file_citation
          )
          end

          sig do
            override.returns(
              {
                index: Integer,
                type: Symbol,
                end_index: Integer,
                file_citation:
                  OpenAI::Beta::Threads::FileCitationDeltaAnnotation::FileCitation,
                start_index: Integer,
                text: String
              }
            )
          end
          def to_hash
          end

          class FileCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The ID of the specific File the citation is from.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            # The specific quote in the file.
            sig { returns(T.nilable(String)) }
            attr_reader :quote

            sig { params(quote: String).void }
            attr_writer :quote

            sig do
              params(file_id: String, quote: String).returns(T.attached_class)
            end
            def self.new(
              # The ID of the specific File the citation is from.
              file_id: nil,
              # The specific quote in the file.
              quote: nil
            )
            end

            sig { override.returns({ file_id: String, quote: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
