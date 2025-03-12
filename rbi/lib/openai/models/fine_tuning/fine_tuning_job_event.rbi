# typed: strong

module OpenAI
  module Models
    FineTuningJobEvent = T.type_alias { FineTuning::FineTuningJobEvent }

    module FineTuning
      class FineTuningJobEvent < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(Integer) }
        def created_at
        end

        sig { params(_: Integer).returns(Integer) }
        def created_at=(_)
        end

        sig { returns(Symbol) }
        def level
        end

        sig { params(_: Symbol).returns(Symbol) }
        def level=(_)
        end

        sig { returns(String) }
        def message
        end

        sig { params(_: String).returns(String) }
        def message=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        sig { returns(T.nilable(T.anything)) }
        def data
        end

        sig { params(_: T.anything).returns(T.anything) }
        def data=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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

        class Level < OpenAI::Enum
          abstract!

          INFO = :info
          WARN = :warn
          ERROR = :error

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Type < OpenAI::Enum
          abstract!

          MESSAGE = :message
          METRICS = :metrics

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
