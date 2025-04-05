# typed: strong

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobWandbIntegration < OpenAI::Internal::Type::BaseModel
        # The name of the project that the new run will be created under.
        sig { returns(String) }
        attr_accessor :project

        # The entity to use for the run. This allows you to set the team or username of
        #   the WandB user that you would like associated with the run. If not set, the
        #   default entity for the registered WandB API key is used.
        sig { returns(T.nilable(String)) }
        attr_accessor :entity

        # A display name to set for the run. If not set, we will use the Job ID as the
        #   name.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # A list of tags to be attached to the newly created run. These tags are passed
        #   through directly to WandB. Some default tags are generated by OpenAI:
        #   "openai/finetune", "openai/{base-model}", "openai/{ftjob-abcdef}".
        sig { returns(T.nilable(T::Array[String])) }
        attr_reader :tags

        sig { params(tags: T::Array[String]).void }
        attr_writer :tags

        # The settings for your integration with Weights and Biases. This payload
        #   specifies the project that metrics will be sent to. Optionally, you can set an
        #   explicit display name for your run, add tags to your run, and set a default
        #   entity (team, username, etc) to be associated with your run.
        sig do
          params(project: String, entity: T.nilable(String), name: T.nilable(String), tags: T::Array[String])
            .returns(T.attached_class)
        end
        def self.new(project:, entity: nil, name: nil, tags: nil); end

        sig do
          override
            .returns({
                       project: String,
                       entity: T.nilable(String),
                       name: T.nilable(String),
                       tags: T::Array[String]
                     })
        end
        def to_hash; end
      end
    end

    FineTuningJobWandbIntegration = FineTuning::FineTuningJobWandbIntegration
  end
end
