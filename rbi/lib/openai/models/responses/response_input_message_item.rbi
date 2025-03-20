# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputMessageItem < OpenAI::BaseModel
        # The unique ID of the message input.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # A list of one or many input items to the model, containing different content
        #   types.
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
        def content
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseInputText,
              OpenAI::Models::Responses::ResponseInputImage,
              OpenAI::Models::Responses::ResponseInputFile
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
              ]
            )
        end
        def content=(_)
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        sig { returns(OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol) }
        def role
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
            .returns(OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
        end
        def role=(_)
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)) }
        def status
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
            .returns(OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
        end
        def status=(_)
        end

        # The type of the message input. Always set to `message`.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol)) }
        def type
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol)
            .returns(OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol)
        end
        def type=(_)
        end

        sig do
          params(
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
          )
            .returns(T.attached_class)
        end
        def self.new(id:, content:, role:, status: nil, type: nil)
        end

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
        def to_hash
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        module Role
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol) }

          USER = T.let(:user, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
          SYSTEM = T.let(:system, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)
          DEVELOPER = T.let(:developer, OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputMessageItem::Role::TaggedSymbol]) }
            def values
            end
          end
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        module Status
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputMessageItem::Status::TaggedSymbol]) }
            def values
            end
          end
        end

        # The type of the message input. Always set to `message`.
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol) }

          MESSAGE = T.let(:message, OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputMessageItem::Type::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
