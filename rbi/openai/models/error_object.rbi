# typed: strong

module OpenAI
  module Models

    class ErrorObject < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::ErrorObject,
          OpenAI::Internal::AnyHash
        )
      end

      sig { returns(T.nilable(String)) }
      attr_accessor :code

      sig { returns(String) }
      attr_accessor :message

      sig { returns(T.nilable(String)) }
      attr_accessor :param

      sig { returns(String) }
      attr_accessor :type

      sig { returns(T.nilable(OpenAI::ErrorObject::Misalignment)) }
      attr_reader :misalignment

      sig { params(misalignment: OpenAI::ErrorObject::Misalignment::OrHash).void }
      attr_writer :misalignment

      sig do
        params(

          code: T.nilable(String),

          message: String,

          param: T.nilable(String),

          type: String,

          misalignment: OpenAI::ErrorObject::Misalignment::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        code:,

        message:,

        param:,

        type:,

        misalignment: nil
      )
      end

      sig do
        override.returns(
          {
            code: T.nilable(String),
            message: String,
            param: T.nilable(String),
            type: String,
            misalignment: OpenAI::ErrorObject::Misalignment
          }
        )
      end
      def to_hash
      end

      class Misalignment < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::ErrorObject::Misalignment,
            OpenAI::Internal::AnyHash
          )
        end

        # The public explanation for this block.
        sig { returns(T.nilable(String)) }
        attr_reader :detailed_explanation

        sig { params(detailed_explanation: String).void }
        attr_writer :detailed_explanation

        # An optional classification; clients must accept additional values.
        sig { returns(T.nilable(T.any(String, OpenAI::ErrorObject::Misalignment::ErrorType::OrSymbol))) }
        attr_reader :error_type

        sig { params(error_type: T.any(String, OpenAI::ErrorObject::Misalignment::ErrorType::OrSymbol)).void }
        attr_writer :error_type

        # An optional public continuation instruction.
        sig { returns(T.nilable(OpenAI::ErrorObject::Misalignment::Steer)) }
        attr_reader :steer

        sig { params(steer: OpenAI::ErrorObject::Misalignment::Steer::OrHash).void }
        attr_writer :steer

        sig do
          params(

            detailed_explanation: String,

            error_type: T.any(String, OpenAI::ErrorObject::Misalignment::ErrorType::OrSymbol),

            steer: OpenAI::ErrorObject::Misalignment::Steer::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The public explanation for this block.
          detailed_explanation: nil,

          # An optional classification; clients must accept additional values.
          error_type: nil,

          # An optional public continuation instruction.

          steer: nil
        )
        end

        sig do
          override.returns(
            {
              detailed_explanation: String,
              error_type: T.any(String, OpenAI::ErrorObject::Misalignment::ErrorType::OrSymbol),
              steer: OpenAI::ErrorObject::Misalignment::Steer
            }
          )
        end
        def to_hash
        end

        # An optional classification; clients must accept additional values.
        module ErrorType
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, OpenAI::ErrorObject::Misalignment::ErrorType::TaggedSymbol) }

          sig { override.returns(T::Array[OpenAI::ErrorObject::Misalignment::ErrorType::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::ErrorObject::Misalignment::ErrorType)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          POTENTIALLY_UNINTENDED_DATA_TRANSFER = T.let(
            :potentially_unintended_data_transfer,
            OpenAI::ErrorObject::Misalignment::ErrorType::TaggedSymbol
          )
          POTENTIALLY_UNINTENDED_DATA_ACCESS = T.let(
            :potentially_unintended_data_access,
            OpenAI::ErrorObject::Misalignment::ErrorType::TaggedSymbol
          )
          POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = T.let(
            :potentially_unintended_destructive_activity,
            OpenAI::ErrorObject::Misalignment::ErrorType::TaggedSymbol
          )
          OTHER = T.let(:other, OpenAI::ErrorObject::Misalignment::ErrorType::TaggedSymbol)

        end

        class Steer < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::ErrorObject::Misalignment::Steer,
              OpenAI::Internal::AnyHash
            )
          end

          # The public continuation instruction.
          sig { returns(String) }
          attr_accessor :message

          # An optional public continuation instruction.
          sig do
            params(

              message: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The public continuation instruction.

            message:
          )
          end

          sig do
            override.returns(
              {message: String}
            )
          end
          def to_hash
          end

        end
      end

    end

  end
end
