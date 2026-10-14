# typed: strong

module OpenAI
  module Models

    module Beta

      ChatKitResponseOutputText = ChatKit::ChatKitResponseOutputText

      module ChatKit

        class ChatKitResponseOutputText < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::ChatKit::ChatKitResponseOutputText,
              OpenAI::Internal::AnyHash
            )
          end

          # Ordered list of annotations attached to the response text.
          sig { returns(T::Array[OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::Variants]) }
          attr_accessor :annotations

          # Assistant generated text.
          sig { returns(String) }
          attr_accessor :text

          # Type discriminator that is always `output_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Assistant response text accompanied by optional annotations.
          sig do
            params(

              annotations: T::Array[
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::OrHash,
                  OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::OrHash
                )
              ],

              text: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Ordered list of annotations attached to the response text.
            annotations:,

            # Assistant generated text.
            text:,

            # Type discriminator that is always `output_text`.

            type: :output_text
          )
          end

          sig do
            override.returns(
              {
                annotations: T::Array[OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::Variants],
                text: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # Annotation object describing a cited source.
          module Annotation
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File,
                OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL
              )
            }

            class File < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File,
                  OpenAI::Internal::AnyHash
                )
              end

              # File attachment referenced by the annotation.
              sig { returns(OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source) }
              attr_reader :source

              sig {
                params(source: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source::OrHash).void
              }
              attr_writer :source

              # Type discriminator that is always `file` for this annotation.
              sig { returns(Symbol) }
              attr_accessor :type

              # Annotation that references an uploaded file.
              sig do
                params(

                  source: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source::OrHash,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # File attachment referenced by the annotation.
                source:,

                # Type discriminator that is always `file` for this annotation.

                type: :file
              )
              end

              sig do
                override.returns(
                  {source: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source, type: Symbol}
                )
              end
              def to_hash
              end

              class Source < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Filename referenced by the annotation.
                sig { returns(String) }
                attr_accessor :filename

                # Type discriminator that is always `file`.
                sig { returns(Symbol) }
                attr_accessor :type

                # File attachment referenced by the annotation.
                sig do
                  params(

                    filename: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # Filename referenced by the annotation.
                  filename:,

                  # Type discriminator that is always `file`.

                  type: :file
                )
                end

                sig do
                  override.returns(
                    {filename: String, type: Symbol}
                  )
                end
                def to_hash
                end

              end
            end

            class URL < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL,
                  OpenAI::Internal::AnyHash
                )
              end

              # URL referenced by the annotation.
              sig { returns(OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source) }
              attr_reader :source

              sig {
                params(source: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source::OrHash).void
              }
              attr_writer :source

              # Type discriminator that is always `url` for this annotation.
              sig { returns(Symbol) }
              attr_accessor :type

              # Annotation that references a URL.
              sig do
                params(

                  source: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source::OrHash,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # URL referenced by the annotation.
                source:,

                # Type discriminator that is always `url` for this annotation.

                type: :url
              )
              end

              sig do
                override.returns(
                  {source: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source, type: Symbol}
                )
              end
              def to_hash
              end

              class Source < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Type discriminator that is always `url`.
                sig { returns(Symbol) }
                attr_accessor :type

                # URL referenced by the annotation.
                sig { returns(String) }
                attr_accessor :url

                # URL referenced by the annotation.
                sig do
                  params(

                    url: String,

                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # URL referenced by the annotation.
                  url:,

                  # Type discriminator that is always `url`.

                  type: :url
                )
                end

                sig do
                  override.returns(
                    {type: Symbol, url: String}
                  )
                end
                def to_hash
                end

              end
            end

            sig { override.returns(T::Array[OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::Variants]) }
            def self.variants
            end

          end

        end

      end

    end

  end
end
