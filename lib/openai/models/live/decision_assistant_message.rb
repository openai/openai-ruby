# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionAssistantMessage < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   The text input to the model.
        #
        #   @return [String, Array<OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::OutputText, OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::Refusal>]
        required :content, union: -> { OpenAI::Live::DecisionAssistantMessage::Content }

        # @!attribute role
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute id
        #   The unique ID of this message item.
        #
        #   @return [String, nil]
        optional :id, String, nil?: true

        # @!attribute phase
        #   Labels an `assistant` message as intermediate commentary (`commentary`) or the
        #   final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        #   sending follow-up requests, preserve and resend phase on all assistant messages
        #   — dropping it can degrade performance. Not used for user messages.
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionAssistantMessage::Phase, nil]
        optional :phase, enum: -> { OpenAI::Live::DecisionAssistantMessage::Phase }, nil?: true

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionAssistantMessage::Type, nil]
        optional :type, enum: -> { OpenAI::Live::DecisionAssistantMessage::Type }

        # @!method initialize(content:, id: nil, phase: nil, type: nil, role: :assistant)
        #   @param content [String, Array<OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::OutputText, OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::Refusal>]
        #     The text input to the model.
        #
        #   @param id [String, nil]
        #     The unique ID of this message item.
        #
        #   @param phase [Symbol, OpenAI::Models::Live::DecisionAssistantMessage::Phase, nil]
        #     Labels an `assistant` message as intermediate commentary (`commentary`) or the
        #     final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        #     sending follow-up requests, preserve and resend phase on all assistant messages
        #     — dropping it can degrade performance. Not used for user messages.
        #
        #   @param type [Symbol, OpenAI::Models::Live::DecisionAssistantMessage::Type]
        #
        #   @param role [Symbol, :assistant]

        # The text input to the model.
        #
        # @see OpenAI::Models::Live::DecisionAssistantMessage#content
        module Content
          extend OpenAI::Internal::Type::Union

          # The text input to the model.
          variant String

          variant -> { OpenAI::Models::Live::DecisionAssistantMessage::Content::PartsArray }

          module Part
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :output_text, -> { OpenAI::Live::DecisionAssistantMessage::Content::Part::OutputText }

            variant :refusal, -> { OpenAI::Live::DecisionAssistantMessage::Content::Part::Refusal }

            class OutputText < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #   The text content.
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #
              #   @return [Symbol, :output_text]
              required :type, const: :output_text

              # @!method initialize(text:, type: :output_text)
              #   @param text [String]
              #     The text content.
              #
              #   @param type [Symbol, :output_text]
            end

            class Refusal < OpenAI::Internal::Type::BaseModel
              # @!attribute refusal
              #   The refusal text.
              #
              #   @return [String]
              required :refusal, String

              # @!attribute type
              #
              #   @return [Symbol, :refusal]
              required :type, const: :refusal

              # @!method initialize(refusal:, type: :refusal)
              #   @param refusal [String]
              #     The refusal text.
              #
              #   @param type [Symbol, :refusal]
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::OutputText, OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::Refusal)]
          end

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::OutputText, OpenAI::Models::Live::DecisionAssistantMessage::Content::Part::Refusal>)]

          # @type [OpenAI::Internal::Type::Converter]
          PartsArray = OpenAI::Internal::Type::ArrayOf[
            union: -> { OpenAI::Live::DecisionAssistantMessage::Content::Part }
          ]
        end

        # Labels an `assistant` message as intermediate commentary (`commentary`) or the
        # final answer (`final_answer`). For models like `gpt-5.3-codex` and beyond, when
        # sending follow-up requests, preserve and resend phase on all assistant messages
        # — dropping it can degrade performance. Not used for user messages.
        #
        # @see OpenAI::Models::Live::DecisionAssistantMessage#phase
        module Phase
          extend OpenAI::Internal::Type::Enum

          COMMENTARY = :commentary
          FINAL_ANSWER = :final_answer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Live::DecisionAssistantMessage#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
