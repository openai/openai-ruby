# typed: strong

module OpenAI
  module Models
    FineTuningJobWandbIntegration = T.type_alias { FineTuning::FineTuningJobWandbIntegration }

    module FineTuning
      class FineTuningJobWandbIntegration < OpenAI::BaseModel
        sig { returns(String) }
        def project
        end

        sig { params(_: String).returns(String) }
        def project=(_)
        end

        sig { returns(T.nilable(String)) }
        def entity
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def entity=(_)
        end

        sig { returns(T.nilable(String)) }
        def name
        end

        sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_)
        end

        sig { returns(T.nilable(T::Array[String])) }
        def tags
        end

        sig { params(_: T::Array[String]).returns(T::Array[String]) }
        def tags=(_)
        end

        sig do
          params(project: String, entity: T.nilable(String), name: T.nilable(String), tags: T::Array[String])
            .returns(T.attached_class)
        end
        def self.new(project:, entity: nil, name: nil, tags: nil)
        end

        sig do
          override
            .returns({
                       project: String,
                       entity: T.nilable(String),
                       name: T.nilable(String),
                       tags: T::Array[String]
                     })
        end
        def to_hash
        end
      end
    end
  end
end
