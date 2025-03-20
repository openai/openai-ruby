# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobEvent < OpenAI::BaseModel
        # The object identifier.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The Unix timestamp (in seconds) for when the fine-tuning job was created.
        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        # The log level of the event.
        sig { returns(OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol) }
        def level
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol)
            .returns(OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol)
        end
        def level=(_)
        end

        # The message of the event.
        sig { returns(String) }
        def message
        end

        sig { params(_: String).returns(String) }
        def message=(_)
        end

        # The object type, which is always "fine_tuning.job.event".
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # The data associated with the event.
        sig { returns(T.nilable(T.anything)) }
        def data
        end

        sig { params(_: T.anything).returns(T.anything) }
        def data=(_)
        end

        # The type of event.
        sig { returns(T.nilable(OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)) }
        def type
        end

        sig do
          params(_: OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)
            .returns(OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)
        end
        def type=(_)
        end

        # Fine-tuning job event object
        sig do
          params(
            id: String,
            created_at: Integer,
            level: OpenAI::Models::FineTuning::FineTuningJobEvent::Level::TaggedSymbol,
            message: String,
            data: T.anything,
            type: OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol,
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
        end

        # The type of event.
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol) }

          MESSAGE = T.let(:message, OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)
          METRICS = T.let(:metrics, OpenAI::Models::FineTuning::FineTuningJobEvent::Type::TaggedSymbol)
        end
      end
    end

    FineTuningJobEvent = FineTuning::FineTuningJobEvent
  end
end
