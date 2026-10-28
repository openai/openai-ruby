# frozen_string_literal: true

require_relative "../../models/embedding"

module OpenAI
  module Models
    class Embedding
      alias_method :embedding_without_base64, :embedding
      private :embedding_without_base64

      def embedding
        value = self[:embedding]
        return embedding_without_base64 unless value.is_a?(String)

        # The generated setter replaces this per-field state on assignment.
        cached = @coerced[:embedding]
        return cached if cached.is_a?(Array)

        # Base64 embedding values contain little-endian float32 samples.
        decoded = begin
          value.unpack1("m0")
        rescue ArgumentError
          nil
        end

        return embedding_without_base64 unless decoded && (decoded.bytesize % 4).zero?

        @coerced[:embedding] = decoded.unpack("e*")
      end

      # Equal embeddings still have equal raw data, so the inherited hash remains valid.
      def ==(other)
        return false unless super
        return true unless self[:embedding].is_a?(String)

        embedding == other.embedding
      rescue OpenAI::Errors::ConversionError
        true
      end
    end
  end
end
