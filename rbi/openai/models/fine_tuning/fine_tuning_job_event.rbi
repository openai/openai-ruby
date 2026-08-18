# typed: strong

module OpenAI
  module Models
    FineTuningJobEvent = FineTuning::FineTuningJobEvent

    module FineTuning
      class FineTuningJobEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::FineTuning::FineTuningJobEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The object identifier.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the fine-tuning job was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The log level of the event.
        sig do
          returns(OpenAI::FineTuning::FineTuningJobEvent::Level::TaggedSymbol)
        end
        attr_accessor :level

        # The message of the event.
        sig { returns(String) }
        attr_accessor :message

        # The object type, which is always "fine_tuning.job.event".
        sig { returns(Symbol) }
        attr_accessor :object

        # The data associated with the event.
        sig { returns(T.nilable(T.anything)) }
        attr_reader :data

        sig { params(data: T.anything).void }
        attr_writer :data

        # The type of event.
        sig do
          returns(
            T.nilable(
              OpenAI::FineTuning::FineTuningJobEvent::Type::TaggedSymbol
            )
          )
        end
        attr_reader :type

        sig do
          params(
            type: OpenAI::FineTuning::FineTuningJobEvent::Type::OrSymbol
          ).void
        end
        attr_writer :type

        # Fine-tuning job event object
        sig do
          params(
            id: String,
            created_at: Integer,
            level: OpenAI::FineTuning::FineTuningJobEvent::Level::OrSymbol,
            message: String,
            data: T.anything,
            type: OpenAI::FineTuning::FineTuningJobEvent::Type::OrSymbol,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The object identifier.
          id:,
          # The Unix timestamp (in seconds) for when the fine-tuning job was created.
          created_at:,
          # The log level of the event.
          level:,
          # The message of the event.
          message:,
          # The data associated with the event.
          data: nil,
          # The type of event.
          type: nil,
          # The object type, which is always "fine_tuning.job.event".
          object: :"fine_tuning.job.event"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              level:
                OpenAI::FineTuning::FineTuningJobEvent::Level::TaggedSymbol,
              message: String,
              object: Symbol,
              data: T.anything,
              type: OpenAI::FineTuning::FineTuningJobEvent::Type::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # The log level of the event.
        module Level
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::FineTuning::FineTuningJobEvent::Level)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          INFO =
            T.let(
              :info,
              OpenAI::FineTuning::FineTuningJobEvent::Level::TaggedSymbol
            )
          WARN =
            T.let(
              :warn,
              OpenAI::FineTuning::FineTuningJobEvent::Level::TaggedSymbol
            )
          ERROR =
            T.let(
              :error,
              OpenAI::FineTuning::FineTuningJobEvent::Level::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::FineTuningJobEvent::Level::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The type of event.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::FineTuning::FineTuningJobEvent::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE =
            T.let(
              :message,
              OpenAI::FineTuning::FineTuningJobEvent::Type::TaggedSymbol
            )
          METRICS =
            T.let(
              :metrics,
              OpenAI::FineTuning::FineTuningJobEvent::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::FineTuning::FineTuningJobEvent::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
