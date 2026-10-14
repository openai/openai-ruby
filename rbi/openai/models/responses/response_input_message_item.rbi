# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseInputMessageItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseInputMessageItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique ID of the message input.
        sig { returns(String) }
        attr_accessor :id

        # A list of one or many input items to the model, containing different content
        # types.
        sig { returns(T::Array[OpenAI::Responses::ResponseInputContent::Variants]) }
        attr_accessor :content

        # The role of the message input. One of `user`, `system`, or `developer`.
        sig { returns(OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol) }
        attr_accessor :role

        # The type of the message input. Always set to `message`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Responses::ResponseInputMessageItem::Status::OrSymbol).void }
        attr_writer :status

        sig do
          params(

            id: String,

            content: T::Array[
              T.any(
                OpenAI::Responses::ResponseInputText::OrHash,
                OpenAI::Responses::ResponseInputImage::OrHash,
                OpenAI::Responses::ResponseInputFile::OrHash
              )
            ],

            role: OpenAI::Responses::ResponseInputMessageItem::Role::OrSymbol,

            status: OpenAI::Responses::ResponseInputMessageItem::Status::OrSymbol,

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
              content: T::Array[OpenAI::Responses::ResponseInputContent::Variants],
              role: OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol,
              type: Symbol,
              status: OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseInputMessageItem::Role) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          USER = T.let(:user, OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
          SYSTEM = T.let(:system, OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
          DEVELOPER = T.let(:developer, OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol]) }
          def self.values
          end
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseInputMessageItem::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
          INCOMPLETE = T.let(:incomplete, OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
