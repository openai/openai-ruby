# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatKitResponseOutputText < OpenAI::Internal::Type::BaseModel
          # @!attribute annotations
          #   Ordered list of annotations attached to the response text.
          #
          #   @return [Array<OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File, OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL>]
          required :annotations,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation] }

          # @!attribute text
          #   Assistant generated text.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   Type discriminator that is always `output_text`.
          #
          #   @return [Symbol, :output_text]
          required :type, const: :output_text

          # @!method initialize(annotations:, text:, type: :output_text)
          #   Assistant response text accompanied by optional annotations.
          #
          #   @param annotations [Array<OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File, OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL>] Ordered list of annotations attached to the response text.
          #
          #   @param text [String] Assistant generated text.
          #
          #   @param type [Symbol, :output_text] Type discriminator that is always `output_text`.

          # Annotation object describing a cited source.
          module Annotation
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Annotation that references an uploaded file.
            variant :file, -> { OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File }

            # Annotation that references a URL.
            variant :url, -> { OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL }

            class File < OpenAI::Internal::Type::BaseModel
              # @!attribute source
              #   File attachment referenced by the annotation.
              #
              #   @return [OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source]
              required :source, -> { OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source }

              # @!attribute type
              #   Type discriminator that is always `file` for this annotation.
              #
              #   @return [Symbol, :file]
              required :type, const: :file

              # @!method initialize(source:, type: :file)
              #   Annotation that references an uploaded file.
              #
              #   @param source [OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File::Source] File attachment referenced by the annotation.
              #
              #   @param type [Symbol, :file] Type discriminator that is always `file` for this annotation.

              # @see OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File#source
              class Source < OpenAI::Internal::Type::BaseModel
                # @!attribute filename
                #   Filename referenced by the annotation.
                #
                #   @return [String]
                required :filename, String

                # @!attribute type
                #   Type discriminator that is always `file`.
                #
                #   @return [Symbol, :file]
                required :type, const: :file

                # @!method initialize(filename:, type: :file)
                #   File attachment referenced by the annotation.
                #
                #   @param filename [String] Filename referenced by the annotation.
                #
                #   @param type [Symbol, :file] Type discriminator that is always `file`.
              end
            end

            class URL < OpenAI::Internal::Type::BaseModel
              # @!attribute source
              #   URL referenced by the annotation.
              #
              #   @return [OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source]
              required :source, -> { OpenAI::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source }

              # @!attribute type
              #   Type discriminator that is always `url` for this annotation.
              #
              #   @return [Symbol, :url]
              required :type, const: :url

              # @!method initialize(source:, type: :url)
              #   Annotation that references a URL.
              #
              #   @param source [OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL::Source] URL referenced by the annotation.
              #
              #   @param type [Symbol, :url] Type discriminator that is always `url` for this annotation.

              # @see OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL#source
              class Source < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #   Type discriminator that is always `url`.
                #
                #   @return [Symbol, :url]
                required :type, const: :url

                # @!attribute url
                #   URL referenced by the annotation.
                #
                #   @return [String]
                required :url, String

                # @!method initialize(url:, type: :url)
                #   URL referenced by the annotation.
                #
                #   @param url [String] URL referenced by the annotation.
                #
                #   @param type [Symbol, :url] Type discriminator that is always `url`.
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::File, OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText::Annotation::URL)]
          end
        end
      end

      ChatKitResponseOutputText = ChatKit::ChatKitResponseOutputText
    end
  end
end
