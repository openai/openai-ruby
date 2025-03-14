# typed: strong

module OpenAI
  module Models
    module Beta
      class StaticFileChunkingStrategyObject < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Beta::StaticFileChunkingStrategy) }
        def static
        end

        sig do
          params(_: OpenAI::Models::Beta::StaticFileChunkingStrategy)
            .returns(OpenAI::Models::Beta::StaticFileChunkingStrategy)
        end
        def static=(_)
        end

        # Always `static`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(static: OpenAI::Models::Beta::StaticFileChunkingStrategy, type: Symbol).returns(T.attached_class) }
        def self.new(static:, type: :static)
        end

        sig { override.returns({static: OpenAI::Models::Beta::StaticFileChunkingStrategy, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
