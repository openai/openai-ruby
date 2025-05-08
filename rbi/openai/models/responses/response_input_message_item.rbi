# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputMessageItem < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The unique ID of the message input.
        sig { returns(String) }
        attr_accessor :id

        # A list of one or many input items to the model, containing different content
        # types.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::ResponseInputText,
                OpenAI::Responses::ResponseInputImage,
                OpenAI::Responses::ResponseInputFile
              )
            ]
          )
        end
        attr_accessor :content

        # The role of the message input. One of `user`, `system`, or `developer`.
        sig do
          returns(
            OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol
          )
        end
        attr_accessor :role

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Responses::ResponseInputMessageItem::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # The type of the message input. Always set to `message`.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::ResponseInputMessageItem::Type::TaggedSymbol
            )
          )
        end
        attr_reader :type

        sig do
          params(
            type: OpenAI::Responses::ResponseInputMessageItem::Type::OrSymbol
          ).void
        end
        attr_writer :type

        sig do
          params(
            id: String,
            content:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseInputText::OrHash,
                  OpenAI::Responses::ResponseInputImage::OrHash,
                  OpenAI::Responses::ResponseInputFile::OrHash
                )
              ],
            role: OpenAI::Responses::ResponseInputMessageItem::Role::OrSymbol,
            status:
              OpenAI::Responses::ResponseInputMessageItem::Status::OrSymbol,
            type: OpenAI::Responses::ResponseInputMessageItem::Type::OrSymbol
          ).returns(T.attached_class)
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
          type: nil
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content:
                T::Array[
                  T.any(
                    OpenAI::Responses::ResponseInputText,
                    OpenAI::Responses::ResponseInputImage,
                    OpenAI::Responses::ResponseInputFile
                  )
                ],
              role:
                OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol,
              status:
                OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol,
              type:
                OpenAI::Responses::ResponseInputMessageItem::Type::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        module Role
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseInputMessageItem::Role)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          USER =
            T.let(
              :user,
              OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol
            )
          SYSTEM =
            T.let(
              :system,
              OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol
            )
          DEVELOPER =
            T.let(
              :developer,
              OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputMessageItem::Role::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseInputMessageItem::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputMessageItem::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The type of the message input. Always set to `message`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseInputMessageItem::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE =
            T.let(
              :message,
              OpenAI::Responses::ResponseInputMessageItem::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputMessageItem::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
