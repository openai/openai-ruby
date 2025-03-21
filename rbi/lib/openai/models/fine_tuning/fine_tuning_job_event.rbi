# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobEvent < OpenAI::BaseModel
        # The object identifier.
        sig { returns(String) }
        attr_accessor :id

        # The Unix timestamp (in seconds) for when the fine-tuning job was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The log level of the event.
        sig { returns(OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol) }
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
        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Models::FineTuning::FineTuningJobEvent::Type::OrSymbol).void }
        attr_writer :type

        # Fine-tuning job event object
        sig do
          params(
            id: String,
            created_at: Integer,
            level: OpenAI::Models::FineTuning::FineTuningJobEvent::Level::OrSymbol,
            message: String,
            data: T.anything,
            type: OpenAI::Models::FineTuning::FineTuningJobEvent::Type::OrSymbol,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, created_at:, level:, message:, data: nil, type: nil, object: :"fine_tuning.job.event")
        end

        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                level: OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol,
                message: String,
                object: Symbol,
                data: T.anything,
                type: OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol
              }
            )
        end
        def to_hash
        end

        # The log level of the event.
        module Level
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Level) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol) }

          INFO = T.let(:info, OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol)
          WARN = T.let(:warn, OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol)
          ERROR = T.let(:error, OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol]) }
          def self.values
          end
        end

        # The type of event.
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol) }

          MESSAGE = T.let(:message, OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)
          METRICS = T.let(:metrics, OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end

    FineTuningJobEvent = FineTuning::FineTuningJobEvent
  end
end
