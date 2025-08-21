# typed: strong

module OpenAI
  module Models
    module Conversations
      class URLCitationBody < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::URLCitationBody,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the last character of the URL citation in the message.
        sig { returns(Integer) }
        attr_accessor :end_index

        # The index of the first character of the URL citation in the message.
        sig { returns(Integer) }
        attr_accessor :start_index

        # The title of the web resource.
        sig { returns(String) }
        attr_accessor :title

        # The type of the URL citation. Always `url_citation`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The URL of the web resource.
        sig { returns(String) }
        attr_accessor :url

        sig do
          params(
            end_index: Integer,
            start_index: Integer,
            title: String,
            url: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the last character of the URL citation in the message.
          end_index:,
          # The index of the first character of the URL citation in the message.
          start_index:,
          # The title of the web resource.
          title:,
          # The URL of the web resource.
          url:,
          # The type of the URL citation. Always `url_citation`.
          type: :url_citation
        )
        end

        sig do
          override.returns(
            {
              end_index: Integer,
              start_index: Integer,
              title: String,
              type: Symbol,
              url: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
