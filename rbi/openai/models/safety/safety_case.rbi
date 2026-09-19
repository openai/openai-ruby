# typed: strong

module OpenAI
  module Models

    SafetyCase = Safety::SafetyCase

    module Safety

      class SafetyCase < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Safety::SafetyCase,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :id

        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(String) }
        attr_accessor :entity_identifier

        sig { returns(OpenAI::Safety::SafetyCase::Notice) }
        attr_reader :notice

        sig { params(notice: OpenAI::Safety::SafetyCase::Notice::OrHash).void }
        attr_writer :notice

        sig { returns(Symbol) }
        attr_accessor :object

        sig { returns(T.nilable(String)) }
        attr_accessor :reason

        sig do
          params(

            id: String,

            created_at: Integer,

            entity_identifier: String,

            notice: OpenAI::Safety::SafetyCase::Notice::OrHash,

            reason: T.nilable(String),

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          id:,

          created_at:,

          entity_identifier:,

          notice:,

          reason:,

          object: :"safety.case"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              entity_identifier: String,
              notice: OpenAI::Safety::SafetyCase::Notice,
              object: Symbol,
              reason: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        class Notice < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Safety::SafetyCase::Notice,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(OpenAI::Safety::SafetyCase::Notice::Type::TaggedSymbol) }
          attr_accessor :type

          sig do
            params(

              type: OpenAI::Safety::SafetyCase::Notice::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            type:
          )
          end

          sig do
            override.returns(
              {type: OpenAI::Safety::SafetyCase::Notice::Type::TaggedSymbol}
            )
          end
          def to_hash
          end

          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Safety::SafetyCase::Notice::Type) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            WARNING = T.let(:warning, OpenAI::Safety::SafetyCase::Notice::Type::TaggedSymbol)
            DEACTIVATION = T.let(:deactivation, OpenAI::Safety::SafetyCase::Notice::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Safety::SafetyCase::Notice::Type::TaggedSymbol]) }
            def self.values
            end
          end
        end

      end

    end

  end
end
