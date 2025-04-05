# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputMessageItem < OpenAI::Internal::Type::BaseModel
        # The unique ID of the message input.
        sig { returns(String) }
        attr_accessor :id

        # A list of one or many input items to the model, containing different content
        # types.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
            ]
          )
        end
        attr_accessor :content

        # The role of the message input. One of `user`, `system`, or `developer`.
        sig { returns(OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol) }
        attr_accessor :role

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Models::Responses::ResponseInputMessageItem::Status::OrSymbol).void }
        attr_writer :status

        # The type of the message input. Always set to `message`.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Models::Responses::ResponseInputMessageItem::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(
            id: String,
            content: T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Internal::AnyHash,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
            ],
            role: OpenAI::Models::Responses::ResponseInputMessageItem::Role::OrSymbol,
            status: OpenAI::Models::Responses::ResponseInputMessageItem::Status::OrSymbol,
            type: OpenAI::Models::Responses::ResponseInputMessageItem::Type::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, content:, role:, status: nil, type: nil); end

        sig do
          override
            .returns(
              {
                id: String,
                content: T::Array[
                  T.any(
                    OpenAI::Models::Responses::ResponseInputText,
                    OpenAI::Models::Responses::ResponseInputImage,
                    OpenAI::Models::Responses::ResponseInputFile
                  )
                ],
                role: OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol,
                status: OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol,
                type: OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol
              }
            )
        end
        def to_hash; end

        # The role of the message input. One of `user`, `system`, or `developer`.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol) }

          USER = T.let(:user, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
          SYSTEM = T.let(:system, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
          DEVELOPER = T.let(:developer, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol]) }
          def self.values; end
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol]) }
          def self.values; end
        end

        # The type of the message input. Always set to `message`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol) }

          MESSAGE = T.let(:message, OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
