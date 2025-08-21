# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class URLCitationBody < OpenAI::Internal::Type::BaseModel
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
    end
  end
end
