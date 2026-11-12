# frozen_string_literal: true

module OpenAI
  module Models
    # A user message containing input text, images, or JSON.
    module DecisionInputMessageUnion
      extend OpenAI::Internal::Type::Union

      discriminator :role

      # A user message containing input text, images, or JSON.
      variant :user, -> { OpenAI::DecisionInputMessage }

      # A developer message containing input text.
      variant :developer, -> { OpenAI::DecisionInputMessageUnion::Developer }

      # A system message containing input text.
      variant :system, -> { OpenAI::DecisionInputMessageUnion::System }

      # An assistant message containing output text or refusals.
      variant :assistant, -> { OpenAI::DecisionInputMessageUnion::Assistant }

      class Developer < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   A text string or an ordered list of input text parts.
        #
        #   @return [String, Array<OpenAI::Models::DecisionInputText>]
        required :content, union: -> { OpenAI::DecisionInputMessageUnion::Developer::Content }

        # @!attribute role
        #
        #   @return [Symbol, :developer]
        required :role, const: :developer

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessageUnion::Developer::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessageUnion::Developer::Type }

        # @!method initialize(content:, type: nil, role: :developer)
        #   A developer message containing input text.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputText>]
        #     A text string or an ordered list of input text parts.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessageUnion::Developer::Type]
        #
        #   @param role [Symbol, :developer]

        # A text string or an ordered list of input text parts.
        #
        # @see OpenAI::Models::DecisionInputMessageUnion::Developer#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessageUnion::Developer::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputText }]
        end

        # @see OpenAI::Models::DecisionInputMessageUnion::Developer#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      class System < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   A text string or an ordered list of input text parts.
        #
        #   @return [String, Array<OpenAI::Models::DecisionInputText>]
        required :content, union: -> { OpenAI::DecisionInputMessageUnion::System::Content }

        # @!attribute role
        #
        #   @return [Symbol, :system]
        required :role, const: :system

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessageUnion::System::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessageUnion::System::Type }

        # @!method initialize(content:, type: nil, role: :system)
        #   A system message containing input text.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputText>]
        #     A text string or an ordered list of input text parts.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessageUnion::System::Type]
        #
        #   @param role [Symbol, :system]

        # A text string or an ordered list of input text parts.
        #
        # @see OpenAI::Models::DecisionInputMessageUnion::System#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessageUnion::System::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputText }]
        end

        # @see OpenAI::Models::DecisionInputMessageUnion::System#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      class Assistant < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   A text string or an ordered list of output text and refusal parts.
        #
        #   @return [String, Array<OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::Refusal>]
        required :content, union: -> { OpenAI::DecisionInputMessageUnion::Assistant::Content }

        # @!attribute role
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute phase
        #   The phase of an assistant message.
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessageUnion::Assistant::Phase, nil]
        optional :phase, enum: -> { OpenAI::DecisionInputMessageUnion::Assistant::Phase }, nil?: true

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessageUnion::Assistant::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessageUnion::Assistant::Type }

        # @!method initialize(content:, phase: nil, type: nil, role: :assistant)
        #   An assistant message containing output text or refusals.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::Refusal>]
        #     A text string or an ordered list of output text and refusal parts.
        #
        #   @param phase [Symbol, OpenAI::Models::DecisionInputMessageUnion::Assistant::Phase, nil]
        #     The phase of an assistant message.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessageUnion::Assistant::Type]
        #
        #   @param role [Symbol, :assistant]

        # A text string or an ordered list of output text and refusal parts.
        #
        # @see OpenAI::Models::DecisionInputMessageUnion::Assistant#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::PartsArray }

          module Part
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :output_text, -> { OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::OutputText }

            variant :refusal, -> { OpenAI::DecisionInputMessageUnion::Assistant::Content::Part::Refusal }

            class OutputText < OpenAI::Internal::Type::BaseModel
              # @!attribute text
              #
              #   @return [String]
              required :text, String

              # @!attribute type
              #
              #   @return [Symbol, :output_text]
              required :type, const: :output_text

              # @!method initialize(text:, type: :output_text)
              #   @param text [String]
              #   @param type [Symbol, :output_text]
            end

            class Refusal < OpenAI::Internal::Type::BaseModel
              # @!attribute refusal
              #
              #   @return [String]
              required :refusal, String

              # @!attribute type
              #
              #   @return [Symbol, :refusal]
              required :type, const: :refusal

              # @!method initialize(refusal:, type: :refusal)
              #   @param refusal [String]
              #   @param type [Symbol, :refusal]
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::Refusal)]
          end

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessageUnion::Assistant::Content::Part::Refusal>)]

          # @type [OpenAI::Internal::Type::Converter]
          PartsArray = OpenAI::Internal::Type::ArrayOf[
            union: -> { OpenAI::DecisionInputMessageUnion::Assistant::Content::Part }
          ]
        end

        # The phase of an assistant message.
        #
        # @see OpenAI::Models::DecisionInputMessageUnion::Assistant#phase
        module Phase
          extend OpenAI::Internal::Type::Enum

          COMMENTARY = :commentary
          FINAL_ANSWER = :final_answer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::DecisionInputMessageUnion::Assistant#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      # @!method self.variants
      #   @return [Array(OpenAI::Models::DecisionInputMessage, OpenAI::Models::DecisionInputMessageUnion::Developer, OpenAI::Models::DecisionInputMessageUnion::System, OpenAI::Models::DecisionInputMessageUnion::Assistant)]
    end
  end
end
