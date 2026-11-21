# typed: strong

module OpenAI
  module Models

    BetaCompactedResponse = Beta::BetaCompactedResponse

    module Beta

      class BetaCompactedResponse < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaCompactedResponse,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique identifier for the compacted response.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (in seconds) when the compacted conversation was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The object type. Always `response.compaction`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The compacted list of output items. This is a list of all user messages,
        # followed by a single compaction item.
        sig { returns(T::Array[OpenAI::Beta::BetaResponseItem::Variants]) }
        attr_accessor :output

        # Token accounting for the compaction pass, including cached, reasoning, and total
        # tokens.
        sig { returns(OpenAI::Beta::BetaResponseUsage) }
        attr_reader :usage

        sig { params(usage: OpenAI::Beta::BetaResponseUsage::OrHash).void }
        attr_writer :usage

        sig { returns(T.nilable(OpenAI::Beta::BetaCompactedResponse::Image)) }
        attr_reader :image

        sig { params(image: OpenAI::Beta::BetaCompactedResponse::Image::OrHash).void }
        attr_writer :image

        sig do
          params(

            id: String,

            created_at: Integer,

            output: T::Array[
              T.any(
                OpenAI::Beta::BetaResponseInputMessageItem::OrHash,
                OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::OrHash,
                OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                OpenAI::Beta::BetaResponseFunctionToolCallItem::OrHash,
                OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::OrHash,
                OpenAI::Beta::BetaResponseItem::AgentMessage::OrHash,
                OpenAI::Beta::BetaResponseItem::MultiAgentCall::OrHash,
                OpenAI::Beta::BetaResponseItem::MultiAgentCallOutput::OrHash,
                OpenAI::Beta::BetaResponseToolSearchCall::OrHash,
                OpenAI::Beta::BetaResponseToolSearchOutputItem::OrHash,
                OpenAI::Beta::BetaResponseItem::AdditionalTools::OrHash,
                OpenAI::Beta::BetaResponseConfigurationUpdateItem::OrHash,
                OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                OpenAI::Beta::BetaResponseItem::Program::OrHash,
                OpenAI::Beta::BetaResponseItem::ProgramOutput::OrHash,
                OpenAI::Beta::BetaResponseCompactionItem::OrHash,
                OpenAI::Beta::BetaResponseItem::ImageGenerationCall::OrHash,
                OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                OpenAI::Beta::BetaResponseItem::LocalShellCall::OrHash,
                OpenAI::Beta::BetaResponseItem::LocalShellCallOutput::OrHash,
                OpenAI::Beta::BetaResponseFunctionShellToolCall::OrHash,
                OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::OrHash,
                OpenAI::Beta::BetaResponseApplyPatchToolCall::OrHash,
                OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::OrHash,
                OpenAI::Beta::BetaResponseItem::McpListTools::OrHash,
                OpenAI::Beta::BetaResponseItem::McpApprovalRequest::OrHash,
                OpenAI::Beta::BetaResponseItem::McpApprovalResponse::OrHash,
                OpenAI::Beta::BetaResponseItem::McpCall::OrHash,
                OpenAI::Beta::BetaResponseCustomToolCallItem::OrHash,
                OpenAI::Beta::BetaResponseCustomToolCallOutputItem::OrHash
              )
            ],

            usage: OpenAI::Beta::BetaResponseUsage::OrHash,

            image: OpenAI::Beta::BetaCompactedResponse::Image::OrHash,

            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique identifier for the compacted response.
          id:,

          # Unix timestamp (in seconds) when the compacted conversation was created.
          created_at:,

          # The compacted list of output items. This is a list of all user messages,
          # followed by a single compaction item.
          output:,

          # Token accounting for the compaction pass, including cached, reasoning, and total
          # tokens.
          usage:,

          image: nil,

          # The object type. Always `response.compaction`.

          object: :"response.compaction"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              object: Symbol,
              output: T::Array[OpenAI::Beta::BetaResponseItem::Variants],
              usage: OpenAI::Beta::BetaResponseUsage,
              image: OpenAI::Beta::BetaCompactedResponse::Image
            }
          )
        end
        def to_hash
        end

        class Image < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaCompactedResponse::Image,
              OpenAI::Internal::AnyHash
            )
          end

          # Effective image context optimization policy.
          sig { returns(OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression::TaggedSymbol) }
          attr_accessor :context_compression

          sig do
            params(

              context_compression: OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Effective image context optimization policy.

            context_compression:
          )
          end

          sig do
            override.returns(
              {context_compression: OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression::TaggedSymbol}
            )
          end
          def to_hash
          end

          # Effective image context optimization policy.
          module ContextCompression
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ENABLED = T.let(:enabled, OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression::TaggedSymbol)
            DISABLED = T.let(:disabled, OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Beta::BetaCompactedResponse::Image::ContextCompression::TaggedSymbol])
            }
            def self.values
            end
          end
        end

      end

    end

  end
end
