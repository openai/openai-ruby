# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionUserMessage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionUserMessage,
            OpenAI::Internal::AnyHash
          )
        end

        # The text input to the model.
        sig { returns(OpenAI::Live::DecisionUserMessage::Content::Variants) }
        attr_accessor :content

        # The message role. Always `user`.
        sig { returns(Symbol) }
        attr_accessor :role

        # The unique ID of this message item.
        sig { returns(T.nilable(String)) }
        attr_accessor :id

        sig { returns(T.nilable(OpenAI::Live::DecisionUserMessage::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Live::DecisionUserMessage::Type::OrSymbol).void }
        attr_writer :type

        sig do
          params(

            content: OpenAI::Live::DecisionUserMessage::Content::Variants,

            id: T.nilable(String),

            type: OpenAI::Live::DecisionUserMessage::Type::OrSymbol,

            role: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The text input to the model.
          content:,

          # The unique ID of this message item.
          id: nil,

          type: nil,

          # The message role. Always `user`.

          role: :user
        )
        end

        sig do
          override.returns(
            {
              content: OpenAI::Live::DecisionUserMessage::Content::Variants,
              role: Symbol,
              id: T.nilable(String),
              type: OpenAI::Live::DecisionUserMessage::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # The text input to the model.
        module Content
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(String, T::Array[OpenAI::Live::DecisionUserMessage::Content::Part::Variants])
          }

          module Part
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Live::DecisionUserMessage::Content::Part::InputText,
                OpenAI::Live::DecisionUserMessage::Content::Part::InputImage,
                OpenAI::Live::DecisionUserMessage::Content::Part::InputJSON
              )
            }

            class InputText < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionUserMessage::Content::Part::InputText,
                  OpenAI::Internal::AnyHash
                )
              end

              # The text input to the model.
              sig { returns(String) }
              attr_accessor :text

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  text: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # The text input to the model.
                text:,

                type: :input_text
              )
              end

              sig do
                override.returns(
                  {text: String, type: Symbol}
                )
              end
              def to_hash
              end

            end

            class InputImage < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionUserMessage::Content::Part::InputImage,
                  OpenAI::Internal::AnyHash
                )
              end

              # A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
              sig { returns(String) }
              attr_accessor :image_url

              sig { returns(Symbol) }
              attr_accessor :type

              # The detail level of the image to be sent to the model. One of `high`, `low`,
              # `auto`, or `original`. Defaults to `auto`.
              sig {
                returns(T.nilable(OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::OrSymbol))
              }
              attr_accessor :detail

              sig do
                params(

                  image_url: String,

                  detail: T.nilable(OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::OrSymbol),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # A base64-encoded image data URL or a publicly accessible HTTP(S) image URL.
                image_url:,

                # The detail level of the image to be sent to the model. One of `high`, `low`,
                # `auto`, or `original`. Defaults to `auto`.
                detail: nil,

                type: :input_image
              )
              end

              sig do
                override.returns(
                  {
                    image_url: String,
                    type: Symbol,
                    detail: T.nilable(OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::OrSymbol)
                  }
                )
              end
              def to_hash
              end

              # The detail level of the image to be sent to the model. One of `high`, `low`,
              # `auto`, or `original`. Defaults to `auto`.
              module Detail
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol = T.type_alias {
                  T.all(Symbol, OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail)
                }
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                LOW = T.let(:low, OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::TaggedSymbol)
                HIGH = T.let(:high, OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::TaggedSymbol)
                AUTO = T.let(:auto, OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::TaggedSymbol)
                ORIGINAL = T.let(
                  :original,
                  OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::TaggedSymbol
                )

                sig {
                  override.returns(
                    T::Array[OpenAI::Live::DecisionUserMessage::Content::Part::InputImage::Detail::TaggedSymbol]
                  )
                }
                def self.values
                end
              end
            end

            class InputJSON < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionUserMessage::Content::Part::InputJSON,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(T.any(T::Hash[Symbol, T.anything], T::Array[T::Hash[Symbol, T.anything]])) }
              attr_accessor :data

              sig { returns(Symbol) }
              attr_accessor :type

              sig do
                params(

                  data: T.any(T::Hash[Symbol, T.anything], T::Array[T::Hash[Symbol, T.anything]]),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                data:,

                type: :input_json
              )
              end

              sig do
                override.returns(
                  {data: T.any(T::Hash[Symbol, T.anything], T::Array[T::Hash[Symbol, T.anything]]), type: Symbol}
                )
              end
              def to_hash
              end

              module Data
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(T::Hash[Symbol, T.anything], T::Array[T::Hash[Symbol, T.anything]]) }

                sig {
                  override.returns(
                    T::Array[OpenAI::Live::DecisionUserMessage::Content::Part::InputJSON::Data::Variants]
                  )
                }
                def self.variants
                end

                DecisionJSONObjectArray = T.let(
                  OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]],
                  OpenAI::Internal::Type::Converter
                )

              end
            end

            sig { override.returns(T::Array[OpenAI::Live::DecisionUserMessage::Content::Part::Variants]) }
            def self.variants
            end

          end

          sig { override.returns(T::Array[OpenAI::Live::DecisionUserMessage::Content::Variants]) }
          def self.variants
          end

          PartsArray = T.let(
            OpenAI::Internal::Type::ArrayOf[union: OpenAI::Live::DecisionUserMessage::Content::Part],
            OpenAI::Internal::Type::Converter
          )

        end

        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionUserMessage::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MESSAGE = T.let(:message, OpenAI::Live::DecisionUserMessage::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::DecisionUserMessage::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
