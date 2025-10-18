# typed: strong

module OpenAI
  module Models
    # The input format for the custom tool. Default is unconstrained text.
    module CustomToolInputFormat
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(
            OpenAI::CustomToolInputFormat::Text,
            OpenAI::CustomToolInputFormat::Grammar
          )
        end

      class Text < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::CustomToolInputFormat::Text,
              OpenAI::Internal::AnyHash
            )
          end

        # Unconstrained text format. Always `text`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # Unconstrained text format. Always `text`.
          type: :text
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end

      class Grammar < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::CustomToolInputFormat::Grammar,
              OpenAI::Internal::AnyHash
            )
          end

        # The grammar definition.
        sig { returns(String) }
        attr_accessor :definition

        # The syntax of the grammar definition. One of `lark` or `regex`.
        sig do
          returns(OpenAI::CustomToolInputFormat::Grammar::Syntax::OrSymbol)
        end
        attr_accessor :syntax

        # Grammar format. Always `grammar`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            definition: String,
            syntax: OpenAI::CustomToolInputFormat::Grammar::Syntax::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The grammar definition.
          definition:,
          # The syntax of the grammar definition. One of `lark` or `regex`.
          syntax:,
          # Grammar format. Always `grammar`.
          type: :grammar
        )
        end

        sig do
          override.returns(
            {
              definition: String,
              syntax: OpenAI::CustomToolInputFormat::Grammar::Syntax::OrSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        # The syntax of the grammar definition. One of `lark` or `regex`.
        module Syntax
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::CustomToolInputFormat::Grammar::Syntax)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          LARK =
            T.let(
              :lark,
              OpenAI::CustomToolInputFormat::Grammar::Syntax::TaggedSymbol
            )
          REGEX =
            T.let(
              :regex,
              OpenAI::CustomToolInputFormat::Grammar::Syntax::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::CustomToolInputFormat::Grammar::Syntax::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end

      sig do
        override.returns(T::Array[OpenAI::CustomToolInputFormat::Variants])
      end
      def self.variants
      end
    end
  end
end
