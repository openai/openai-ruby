# typed: strong

module OpenAI
  module Models

    class VideoCreateError < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::VideoCreateError,
          OpenAI::Internal::AnyHash
        )
      end

      # A machine-readable error code that was returned.
      sig { returns(String) }
      attr_accessor :code

      # A human-readable description of the error that was returned.
      sig { returns(String) }
      attr_accessor :message

      sig { returns(T.nilable(OpenAI::VideoCreateError::Misalignment)) }
      attr_reader :misalignment

      sig { params(misalignment: OpenAI::VideoCreateError::Misalignment::OrHash).void }
      attr_writer :misalignment

      # An error that occurred while generating the response.
      sig do
        params(

          code: String,

          message: String,

          misalignment: OpenAI::VideoCreateError::Misalignment::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # A machine-readable error code that was returned.
        code:,

        # A human-readable description of the error that was returned.
        message:,

        misalignment: nil
      )
      end

      sig do
        override.returns(
          {code: String, message: String, misalignment: OpenAI::VideoCreateError::Misalignment}
        )
      end
      def to_hash
      end

      class Misalignment < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::VideoCreateError::Misalignment,
            OpenAI::Internal::AnyHash
          )
        end

        # The public explanation for this block.
        sig { returns(T.nilable(String)) }
        attr_reader :detailed_explanation

        sig { params(detailed_explanation: String).void }
        attr_writer :detailed_explanation

        # An optional classification; clients must accept additional values.
        sig { returns(T.nilable(OpenAI::VideoCreateError::Misalignment::ErrorType::Variants)) }
        attr_reader :error_type

        sig { params(error_type: T.any(String, OpenAI::VideoCreateError::Misalignment::ErrorType::OrSymbol)).void }
        attr_writer :error_type

        # An optional public continuation instruction.
        sig { returns(T.nilable(OpenAI::VideoCreateError::Misalignment::Steer)) }
        attr_reader :steer

        sig { params(steer: OpenAI::VideoCreateError::Misalignment::Steer::OrHash).void }
        attr_writer :steer

        sig do
          params(

            detailed_explanation: String,

            error_type: T.any(String, OpenAI::VideoCreateError::Misalignment::ErrorType::OrSymbol),

            steer: OpenAI::VideoCreateError::Misalignment::Steer::OrHash
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
              error_type: OpenAI::VideoCreateError::Misalignment::ErrorType::Variants,
              steer: OpenAI::VideoCreateError::Misalignment::Steer
            }
          )
        end
        def to_hash
        end

        # An optional classification; clients must accept additional values.
        module ErrorType
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, OpenAI::VideoCreateError::Misalignment::ErrorType::TaggedSymbol) }

          sig { override.returns(T::Array[OpenAI::VideoCreateError::Misalignment::ErrorType::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::VideoCreateError::Misalignment::ErrorType)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          POTENTIALLY_UNINTENDED_DATA_TRANSFER = T.let(
            :potentially_unintended_data_transfer,
            OpenAI::VideoCreateError::Misalignment::ErrorType::TaggedSymbol
          )
          POTENTIALLY_UNINTENDED_DATA_ACCESS = T.let(
            :potentially_unintended_data_access,
            OpenAI::VideoCreateError::Misalignment::ErrorType::TaggedSymbol
          )
          POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = T.let(
            :potentially_unintended_destructive_activity,
            OpenAI::VideoCreateError::Misalignment::ErrorType::TaggedSymbol
          )
          OTHER = T.let(:other, OpenAI::VideoCreateError::Misalignment::ErrorType::TaggedSymbol)

        end

        class Steer < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::VideoCreateError::Misalignment::Steer,
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
