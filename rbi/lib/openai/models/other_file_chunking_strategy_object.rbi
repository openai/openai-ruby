# typed: strong

module OpenAI
  module Models
    class OtherFileChunkingStrategyObject < OpenAI::BaseModel
      # Always `other`.
      sig { returns(Symbol) }
      attr_accessor :type

      # This is returned when the chunking strategy is unknown. Typically, this is
      #   because the file was indexed before the `chunking_strategy` concept was
      #   introduced in the API.
      sig { params(type: Symbol).returns(T.attached_class) }
      def self.new(type: :other)
      end

      sig { override.returns({type: Symbol}) }
      def to_hash
      end
    end
  end
end
