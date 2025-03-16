# typed: strong

module OpenAI
  module Models
    FineTuningJobEvent = T.type_alias { FineTuning::FineTuningJobEvent }

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
        sig { returns(Symbol) }
        def level
        end

        sig { params(_: Symbol).returns(Symbol) }
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
        sig { returns(T.nilable(Symbol)) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Fine-tuning job event object
        sig do
          params(
            id: String,
            created_at: Integer,
            level: Symbol,
            message: String,
            data: T.anything,
            type: Symbol,
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
                level: Symbol,
                message: String,
                object: Symbol,
                data: T.anything,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # The log level of the event.
        class Level < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          INFO = :info
          WARN = :warn
          ERROR = :error
        end

        # The type of event.
        class Type < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          MESSAGE = :message
          METRICS = :metrics
        end
      end
    end
  end
end
