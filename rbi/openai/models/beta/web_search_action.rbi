# typed: strong

module OpenAI
  module Models

    module Beta

      # An action performed by the web search tool.
      module WebSearchAction
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::WebSearchAction::Search,
            OpenAI::Beta::WebSearchAction::OpenPage,
            OpenAI::Beta::WebSearchAction::FindInPage,
            OpenAI::Beta::WebSearchAction::Other
          )
        end

        class Search < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::WebSearchAction::Search,
              OpenAI::Internal::AnyHash
            )
          end

          # The search queries, when multiple queries were used.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :queries

          # The search query, when a single query was used.
          sig { returns(T.nilable(String)) }
          attr_accessor :query

          # The type of the object. Always `search`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A search query or group of search queries.
          sig do
            params(

              queries: T.nilable(T::Array[String]),

              query: T.nilable(String),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The search queries, when multiple queries were used.
            queries:,

            # The search query, when a single query was used.
            query:,

            # The type of the object. Always `search`.

            type: :search
          )
          end

          sig do
            override.returns(
              {queries: T.nilable(T::Array[String]), query: T.nilable(String), type: Symbol}
            )
          end
          def to_hash
          end

        end

        class OpenPage < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::WebSearchAction::OpenPage,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `open_page`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The URL of the page that was opened.
          sig { returns(T.nilable(String)) }
          attr_accessor :url

          # Opens a web page.
          sig do
            params(

              url: T.nilable(String),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The URL of the page that was opened.
            url:,

            # The type of the object. Always `open_page`.

            type: :open_page
          )
          end

          sig do
            override.returns(
              {type: Symbol, url: T.nilable(String)}
            )
          end
          def to_hash
          end

        end

        class FindInPage < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::WebSearchAction::FindInPage,
              OpenAI::Internal::AnyHash
            )
          end

          # The text pattern that was searched for.
          sig { returns(T.nilable(String)) }
          attr_accessor :pattern

          # The type of the object. Always `find_in_page`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The URL of the page that was searched.
          sig { returns(T.nilable(String)) }
          attr_accessor :url

          # Finds text within a web page.
          sig do
            params(

              pattern: T.nilable(String),

              url: T.nilable(String),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The text pattern that was searched for.
            pattern:,

            # The URL of the page that was searched.
            url:,

            # The type of the object. Always `find_in_page`.

            type: :find_in_page
          )
          end

          sig do
            override.returns(
              {pattern: T.nilable(String), type: Symbol, url: T.nilable(String)}
            )
          end
          def to_hash
          end

        end

        class Other < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::WebSearchAction::Other,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `other`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Another web search action.
          sig do
            params(

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The type of the object. Always `other`.

            type: :other
          )
          end

          sig do
            override.returns(
              {type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::WebSearchAction::Variants]) }
        def self.variants
        end

      end

    end

  end
end
