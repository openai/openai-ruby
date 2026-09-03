# typed: strong

module OpenAI
  module Models

    SafetyAlert = Safety::SafetyAlert

    module Safety

      class SafetyAlert < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Safety::SafetyAlert,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :id

        sig { returns(Integer) }
        attr_accessor :created_at

        sig { returns(OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol) }
        attr_accessor :error_type

        sig { returns(String) }
        attr_accessor :model

        sig { returns(Symbol) }
        attr_accessor :object

        # A customer-safe description derived from error_type, or null for zero data
        # retention requests.
        sig { returns(T.nilable(String)) }
        attr_accessor :reason

        sig { returns(String) }
        attr_accessor :request_id

        # Whether block registration succeeded for this request. This does not confirm
        # that response execution stopped.
        sig { returns(T::Boolean) }
        attr_accessor :request_paused

        sig { returns(String) }
        attr_accessor :response_id

        sig do
          params(

            id: String,

            created_at: Integer,

            error_type: OpenAI::Safety::SafetyAlert::ErrorType::OrSymbol,

            model: String,

            reason: T.nilable(String),

            request_id: String,

            request_paused: T::Boolean,

            response_id: String,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          id:,

          created_at:,

          error_type:,

          model:,

          # A customer-safe description derived from error_type, or null for zero data
          # retention requests.
          reason:,

          request_id:,

          # Whether block registration succeeded for this request. This does not confirm
          # that response execution stopped.
          request_paused:,

          response_id:,

          object: :"safety.alert"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              error_type: OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol,
              model: String,
              object: Symbol,
              reason: T.nilable(String),
              request_id: String,
              request_paused: T::Boolean,
              response_id: String
            }
          )
        end
        def to_hash
        end

        module ErrorType
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Safety::SafetyAlert::ErrorType) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          POTENTIALLY_UNINTENDED_DATA_TRANSFER = T.let(
            :potentially_unintended_data_transfer,
            OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol
          )
          POTENTIALLY_UNINTENDED_DATA_ACCESS = T.let(
            :potentially_unintended_data_access,
            OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol
          )
          POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = T.let(
            :potentially_unintended_destructive_activity,
            OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol
          )
          OTHER = T.let(:other, OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Safety::SafetyAlert::ErrorType::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
