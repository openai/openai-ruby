# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputText < OpenAI::Internal::Type::BaseModel
        # @!attribute annotations
        #   The annotations of the text output.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::ContainerFileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath>]
        required :annotations,
                 -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseOutputText::Annotation] }

        # @!attribute text
        #   The text output from the model.
        #
        #   @return [String]
        required :text, String

        response_only do
          # @!attribute parsed
          #   The parsed contents of the output, if JSON schema is specified.
          #
          #   @return [Object, nil]
          optional :parsed, OpenAI::StructuredOutput::ParsedJson
        end

        # @!attribute type
        #   The type of the output text. Always `output_text`.
        #
        #   @return [Symbol, :output_text]
        required :type, const: :output_text

        # @!attribute logprobs
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseOutputText::Logprob>, nil]
        optional :logprobs, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseOutputText::Logprob] }

        # @!method initialize(annotations:, text:, logprobs: nil, type: :output_text)
        #   A text output from the model.
        #
        #   @param annotations [Array<OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::ContainerFileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath>] The annotations of the text output.
        #
        #   @param text [String] The text output from the model.
        #
        #   @param logprobs [Array<OpenAI::Models::Responses::ResponseOutputText::Logprob>]
        #
        #   @param type [Symbol, :output_text] The type of the output text. Always `output_text`.

        # An annotation that applies to a span of output text.
        module Annotation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A citation to a file.
          variant :file_citation, -> { OpenAI::Responses::ResponseOutputText::Annotation::FileCitation }

          # A citation for a web resource used to generate a model response.
          variant :url_citation, -> { OpenAI::Responses::ResponseOutputText::Annotation::URLCitation }

          # A citation for a container file used to generate a model response.
          variant :container_file_citation,
                  -> { OpenAI::Responses::ResponseOutputText::Annotation::ContainerFileCitation }

          # A path to a file.
          variant :file_path, -> { OpenAI::Responses::ResponseOutputText::Annotation::FilePath }

          class FileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the file.
            #
            #   @return [String]
            required :file_id, String

            # @!attribute filename
            #   The filename of the file cited.
            #
            #   @return [String]
            required :filename, String

            # @!attribute index
            #   The index of the file in the list of files.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   The type of the file citation. Always `file_citation`.
            #
            #   @return [Symbol, :file_citation]
            required :type, const: :file_citation

            # @!method initialize(file_id:, filename:, index:, type: :file_citation)
            #   A citation to a file.
            #
            #   @param file_id [String] The ID of the file.
            #
            #   @param filename [String] The filename of the file cited.
            #
            #   @param index [Integer] The index of the file in the list of files.
            #
            #   @param type [Symbol, :file_citation] The type of the file citation. Always `file_citation`.
          end

          class URLCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute end_index
            #   The index of the last character of the URL citation in the message.
            #
            #   @return [Integer]
            required :end_index, Integer

            # @!attribute start_index
            #   The index of the first character of the URL citation in the message.
            #
            #   @return [Integer]
            required :start_index, Integer

            # @!attribute title
            #   The title of the web resource.
            #
            #   @return [String]
            required :title, String

            # @!attribute type
            #   The type of the URL citation. Always `url_citation`.
            #
            #   @return [Symbol, :url_citation]
            required :type, const: :url_citation

            # @!attribute url
            #   The URL of the web resource.
            #
            #   @return [String]
            required :url, String

            # @!method initialize(end_index:, start_index:, title:, url:, type: :url_citation)
            #   A citation for a web resource used to generate a model response.
            #
            #   @param end_index [Integer] The index of the last character of the URL citation in the message.
            #
            #   @param start_index [Integer] The index of the first character of the URL citation in the message.
            #
            #   @param title [String] The title of the web resource.
            #
            #   @param url [String] The URL of the web resource.
            #
            #   @param type [Symbol, :url_citation] The type of the URL citation. Always `url_citation`.
          end

          class ContainerFileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute container_id
            #   The ID of the container file.
            #
            #   @return [String]
            required :container_id, String

            # @!attribute end_index
            #   The index of the last character of the container file citation in the message.
            #
            #   @return [Integer]
            required :end_index, Integer

            # @!attribute file_id
            #   The ID of the file.
            #
            #   @return [String]
            required :file_id, String

            # @!attribute filename
            #   The filename of the container file cited.
            #
            #   @return [String]
            required :filename, String

            # @!attribute start_index
            #   The index of the first character of the container file citation in the message.
            #
            #   @return [Integer]
            required :start_index, Integer

            # @!attribute type
            #   The type of the container file citation. Always `container_file_citation`.
            #
            #   @return [Symbol, :container_file_citation]
            required :type, const: :container_file_citation

            # @!method initialize(container_id:, end_index:, file_id:, filename:, start_index:, type: :container_file_citation)
            #   A citation for a container file used to generate a model response.
            #
            #   @param container_id [String] The ID of the container file.
            #
            #   @param end_index [Integer] The index of the last character of the container file citation in the message.
            #
            #   @param file_id [String] The ID of the file.
            #
            #   @param filename [String] The filename of the container file cited.
            #
            #   @param start_index [Integer] The index of the first character of the container file citation in the message.
            #
            #   @param type [Symbol, :container_file_citation] The type of the container file citation. Always `container_file_citation`.
          end

          class FilePath < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the file.
            #
            #   @return [String]
            required :file_id, String

            # @!attribute index
            #   The index of the file in the list of files.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   The type of the file path. Always `file_path`.
            #
            #   @return [Symbol, :file_path]
            required :type, const: :file_path

            # @!method initialize(file_id:, index:, type: :file_path)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath} for more
            #   details.
            #
            #   A path to a file.
            #
            #   @param file_id [String] The ID of the file.
            #
            #   @param index [Integer] The index of the file in the list of files.
            #
            #   @param type [Symbol, :file_path] The type of the file path. Always `file_path`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::ContainerFileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath)]
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          # @!attribute token
          #
          #   @return [String]
          required :token, String

          # @!attribute bytes
          #
          #   @return [Array<Integer>]
          required :bytes, OpenAI::Internal::Type::ArrayOf[Integer]

          # @!attribute logprob
          #
          #   @return [Float]
          required :logprob, Float

          # @!attribute top_logprobs
          #
          #   @return [Array<OpenAI::Models::Responses::ResponseOutputText::Logprob::TopLogprob>]
          required :top_logprobs,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseOutputText::Logprob::TopLogprob] }

          # @!method initialize(token:, bytes:, logprob:, top_logprobs:)
          #   The log probability of a token.
          #
          #   @param token [String]
          #   @param bytes [Array<Integer>]
          #   @param logprob [Float]
          #   @param top_logprobs [Array<OpenAI::Models::Responses::ResponseOutputText::Logprob::TopLogprob>]

          class TopLogprob < OpenAI::Internal::Type::BaseModel
            # @!attribute token
            #
            #   @return [String]
            required :token, String

            # @!attribute bytes
            #
            #   @return [Array<Integer>]
            required :bytes, OpenAI::Internal::Type::ArrayOf[Integer]

            # @!attribute logprob
            #
            #   @return [Float]
            required :logprob, Float

            # @!method initialize(token:, bytes:, logprob:)
            #   The top log probability of a token.
            #
            #   @param token [String]
            #   @param bytes [Array<Integer>]
            #   @param logprob [Float]
          end
        end
      end
    end
  end
end
