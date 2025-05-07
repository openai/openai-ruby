# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class FileCitationAnnotation < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig { returns(Integer) }
          attr_accessor :end_index

          sig do
            returns(OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation)
          end
          attr_reader :file_citation

          sig do
            params(
              file_citation:
                OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation::OrHash
            ).void
          end
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
              file_citation:
                OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation::OrHash,
              start_index: Integer,
              text: String,
              type: Symbol
            ).returns(T.attached_class)
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
                file_citation:
                  OpenAI::Beta::Threads::FileCitationAnnotation::FileCitation,
                start_index: Integer,
                text: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class FileCitation < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The ID of the specific File the citation is from.
            sig { returns(String) }
            attr_accessor :file_id

            sig { params(file_id: String).returns(T.attached_class) }
            def self.new(
              # The ID of the specific File the citation is from.
              file_id:
            )
            end

            sig { override.returns({ file_id: String }) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
