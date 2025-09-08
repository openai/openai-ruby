# typed: strong

module OpenAI
  module Models
    module Realtime
      class Models < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Realtime::Models, OpenAI::Internal::AnyHash)
          end

        # The description of the function, including guidance on when and how to call it,
        # and guidance about what to tell the user when calling (if anything).
        sig { returns(T.nilable(String)) }
        attr_reader :description

        sig { params(description: String).void }
        attr_writer :description

        # The name of the function.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        # Parameters of the function in JSON Schema.
        sig { returns(T.nilable(T.anything)) }
        attr_reader :parameters

        sig { params(parameters: T.anything).void }
        attr_writer :parameters

        # The type of the tool, i.e. `function`.
        sig { returns(T.nilable(OpenAI::Realtime::Models::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Realtime::Models::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(
            description: String,
            name: String,
            parameters: T.anything,
            type: OpenAI::Realtime::Models::Type::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The description of the function, including guidance on when and how to call it,
          # and guidance about what to tell the user when calling (if anything).
          description: nil,
          # The name of the function.
          name: nil,
          # Parameters of the function in JSON Schema.
          parameters: nil,
          # The type of the tool, i.e. `function`.
          type: nil
        )
        end

        sig do
          override.returns(
            {
              description: String,
              name: String,
              parameters: T.anything,
              type: OpenAI::Realtime::Models::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The type of the tool, i.e. `function`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Realtime::Models::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          FUNCTION =
            T.let(:function, OpenAI::Realtime::Models::Type::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::Models::Type::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
