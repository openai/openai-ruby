# typed: strong

module OpenAI
  module Models

    BetaResponseInputMessageItem = Beta::BetaResponseInputMessageItem

    module Beta

      class BetaResponseInputMessageItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseInputMessageItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the message input.
        sig { returns(String) }
        attr_accessor :id

        # A list of one or many input items to the model, containing different content
        # types.
        sig { returns(T::Array[OpenAI::Beta::BetaResponseInputContent::Variants]) }
        attr_accessor :content

        # The role of the message input. One of `user`, `system`, or `developer`.
        sig { returns(OpenAI::Beta::BetaResponseInputMessageItem::Role::TaggedSymbol) }
        attr_accessor :role

        # The type of the message input. Always set to `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that produced this item.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseInputMessageItem::Agent)) }
        attr_reader :agent

        sig { params(agent: T.nilable(OpenAI::Beta::BetaResponseInputMessageItem::Agent::OrHash)).void }
        attr_writer :agent

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseInputMessageItem::Status::TaggedSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Beta::BetaResponseInputMessageItem::Status::OrSymbol).void }
        attr_writer :status

        sig do
          params(

            id: String,

            content: T::Array[
              T.any(
                OpenAI::Beta::BetaResponseInputText::OrHash,
                OpenAI::Beta::BetaResponseInputImage::OrHash,
                OpenAI::Beta::BetaResponseInputFile::OrHash
              )
            ],

            role: OpenAI::Beta::BetaResponseInputMessageItem::Role::OrSymbol,

            agent: T.nilable(OpenAI::Beta::BetaResponseInputMessageItem::Agent::OrHash),

            status: OpenAI::Beta::BetaResponseInputMessageItem::Status::OrSymbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique ID of the message input.
          id:,

          # A list of one or many input items to the model, containing different content
          # types.
          content:,

          # The role of the message input. One of `user`, `system`, or `developer`.
          role:,

          # The agent that produced this item.
          agent: nil,

          # The status of item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          status: nil,

          # The type of the message input. Always set to `message`.

          type: :message
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content: T::Array[OpenAI::Beta::BetaResponseInputContent::Variants],
              role: OpenAI::Beta::BetaResponseInputMessageItem::Role::TaggedSymbol,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseInputMessageItem::Agent),
              status: OpenAI::Beta::BetaResponseInputMessageItem::Status::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::BetaResponseInputMessageItem::Role) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          USER = T.let(:user, OpenAI::Beta::BetaResponseInputMessageItem::Role::TaggedSymbol)
          SYSTEM = T.let(:system, OpenAI::Beta::BetaResponseInputMessageItem::Role::TaggedSymbol)
          DEVELOPER = T.let(:developer, OpenAI::Beta::BetaResponseInputMessageItem::Role::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::BetaResponseInputMessageItem::Role::TaggedSymbol]) }
          def self.values
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInputMessageItem::Agent,
              OpenAI::Internal::AnyHash
            )
          end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that produced this item.
          sig do
            params(

              agent_name: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The canonical name of the agent that produced this item.

            agent_name:
          )
          end

          sig do
            override.returns(
              {agent_name: String}
            )
          end
          def to_hash
          end

        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::BetaResponseInputMessageItem::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Beta::BetaResponseInputMessageItem::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Beta::BetaResponseInputMessageItem::Status::TaggedSymbol)
          INCOMPLETE = T.let(:incomplete, OpenAI::Beta::BetaResponseInputMessageItem::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::BetaResponseInputMessageItem::Status::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
