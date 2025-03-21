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
        attr_accessor :content

        # The role of the message input. One of `user`, `assistant`, `system`, or
        #   `developer`.
        sig { returns(OpenAI::Models::Responses::EasyInputMessage::Role::OrSymbol) }
        attr_accessor :role

        # The type of the message input. Always `message`.
        sig { returns(T.nilable(OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Models::Responses::EasyInputMessage::Type::OrSymbol).void }
        attr_writer :type

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
                OpenAI::Util::AnyHash,
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

          class << self
            sig do
              override
                .returns(
                  [
                    String,
                    T::Array[
                                      T.any(
                                        OpenAI::Models::Responses::ResponseInputText,
                                        OpenAI::Models::Responses::ResponseInputImage,
                                        OpenAI::Models::Responses::ResponseInputFile
                                      )
                                      ]
                  ]
                )
            end
            def variants
            end
          end
        end

        # The role of the message input. One of `user`, `assistant`, `system`, or
        #   `developer`.
        module Role
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::EasyInputMessage::Role) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol) }

          USER = T.let(:user, OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol)
          ASSISTANT = T.let(:assistant, OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol)
          SYSTEM = T.let(:system, OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol)
          DEVELOPER = T.let(:developer, OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::EasyInputMessage::Role::TaggedSymbol]) }
            def values
            end
          end
        end

        # The type of the message input. Always `message`.
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::EasyInputMessage::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::EasyInputMessage::Type::TaggedSymbol) }

          MESSAGE = T.let(:message, OpenAI::Models::Responses::EasyInputMessage::Type::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::EasyInputMessage::Type::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
