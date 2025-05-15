# typed: strong

module OpenAI
  module Models
    module Beta
      class TruncationObject < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::TruncationObject, OpenAI::Internal::AnyHash)
          end

        # The truncation strategy to use for the thread. The default is `auto`. If set to
        # `last_messages`, the thread will be truncated to the n most recent messages in
        # the thread. When set to `auto`, messages in the middle of the thread will be
        # dropped to fit the context length of the model, `max_prompt_tokens`.
        sig { returns(OpenAI::Beta::TruncationObject::Type::OrSymbol) }
        attr_accessor :type

        # The number of most recent messages from the thread when constructing the context
        # for the run.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :last_messages

        # Controls for how a thread will be truncated prior to the run. Use this to
        # control the intial context window of the run.
        sig do
          params(
            type: OpenAI::Beta::TruncationObject::Type::OrSymbol,
            last_messages: T.nilable(Integer)
          ).returns(T.attached_class)
        end
        def self.new(
          # The truncation strategy to use for the thread. The default is `auto`. If set to
          # `last_messages`, the thread will be truncated to the n most recent messages in
          # the thread. When set to `auto`, messages in the middle of the thread will be
          # dropped to fit the context length of the model, `max_prompt_tokens`.
          type:,
          # The number of most recent messages from the thread when constructing the context
          # for the run.
          last_messages: nil
        )
        end

        sig do
          override.returns(
            {
              type: OpenAI::Beta::TruncationObject::Type::OrSymbol,
              last_messages: T.nilable(Integer)
            }
          )
        end
        def to_hash
        end

        # The truncation strategy to use for the thread. The default is `auto`. If set to
        # `last_messages`, the thread will be truncated to the n most recent messages in
        # the thread. When set to `auto`, messages in the middle of the thread will be
        # dropped to fit the context length of the model, `max_prompt_tokens`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Beta::TruncationObject::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(:auto, OpenAI::Beta::TruncationObject::Type::TaggedSymbol)
          LAST_MESSAGES =
            T.let(
              :last_messages,
              OpenAI::Beta::TruncationObject::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::TruncationObject::Type::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
