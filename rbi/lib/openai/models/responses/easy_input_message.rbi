# typed: strong

module OpenAI
  module Models
    module Responses
      class EasyInputMessage < OpenAI::BaseModel
        # Text, image, or audio input to the model, used to generate a response. Can also
        #   contain previous assistant responses.
        sig do
          returns(
            T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
              ]
            )
          )
        end
        def content
        end

        sig do
          params(
            _: T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
              ]
            )
          )
            .returns(
              T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Responses::ResponseInputText,
                  OpenAI::Models::Responses::ResponseInputImage,
                  OpenAI::Models::Responses::ResponseInputFile
                )
                ]
              )
            )
        end
        def content=(_)
        end

        # The role of the message input. One of `user`, `assistant`, `system`, or
        #   `developer`.
        sig { returns(OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol) }
        def role
        end

        sig do
          params(_: OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol)
            .returns(OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol)
        end
        def role=(_)
        end

        # The type of the message input. Always `message`.
        sig { returns(T.nilable(OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol)) }
        def type
        end

        sig do
          params(_: OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol)
            .returns(OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol)
        end
        def type=(_)
        end

        # A message input to the model with a role indicating instruction following
        #   hierarchy. Instructions given with the `developer` or `system` role take
        #   precedence over instructions given with the `user` role. Messages with the
        #   `assistant` role are presumed to have been generated by the model in previous
        #   interactions.
        sig do
          params(
            content: T.any(
              String,
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseInputText,
                OpenAI::Models::Responses::ResponseInputImage,
                OpenAI::Models::Responses::ResponseInputFile
              )
              ]
            ),
            role: OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol,
            type: OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, role:, type: nil)
        end

        sig do
          override
            .returns(
              {
                content: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Responses::ResponseInputText,
                    OpenAI::Models::Responses::ResponseInputImage,
                    OpenAI::Models::Responses::ResponseInputFile
                  )
                  ]
                ),
                role: OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol,
                type: OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol
              }
            )
        end
        def to_hash
        end

        # Text, image, or audio input to the model, used to generate a response. Can also
        #   contain previous assistant responses.
        module Content
          extend OpenAI::Union

          Variants =
            type_template(:out) do
              {
                fixed: T.any(
                  String,
                  T::Array[
                  T.any(
                    OpenAI::Models::Responses::ResponseInputText,
                    OpenAI::Models::Responses::ResponseInputImage,
                    OpenAI::Models::Responses::ResponseInputFile
                  )
                  ]
                )
              }
            end
        end

        # The role of the message input. One of `user`, `assistant`, `system`, or
        #   `developer`.
        module Role
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::EasyInputMessage::Role) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol) }

          USER = T.let(:user, OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol)
          ASSISTANT = T.let(:assistant, OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol)
          SYSTEM = T.let(:system, OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol)
          DEVELOPER = T.let(:developer, OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol)
        end

        # The type of the message input. Always `message`.
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::EasyInputMessage::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::EasyInputMessage::Type::TaggedSymbol) }

          MESSAGE = T.let(:message, OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol)
        end
      end
    end
  end
end
