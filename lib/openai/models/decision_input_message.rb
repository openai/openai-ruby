# frozen_string_literal: true

module OpenAI
  module Models
    # A user message containing input text, images, or JSON.
    module DecisionInputMessage
      extend OpenAI::Internal::Type::Union

      discriminator :role

      # A user message containing input text, images, or JSON.
      variant :user, -> { OpenAI::DecisionInputMessage::User }

      # A developer message containing input text.
      variant :developer, -> { OpenAI::DecisionInputMessage::Developer }

      # A system message containing input text.
      variant :system, -> { OpenAI::DecisionInputMessage::System }

      # An assistant message containing output text or refusals.
      variant :assistant, -> { OpenAI::DecisionInputMessage::Assistant }

      class User < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   A text string or an ordered list of text, image, and JSON parts.
        #
        #   @return [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON>]
        required :content, union: -> { OpenAI::DecisionInputMessage::User::Content }

        # @!attribute role
        #
        #   @return [Symbol, :user]
        required :role, const: :user

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessage::User::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessage::User::Type }

        # @!method initialize(content:, type: nil, role: :user)
        #   A user message containing input text, images, or JSON.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON>]
        #     A text string or an ordered list of text, image, and JSON parts.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessage::User::Type]
        #
        #   @param role [Symbol, :user]

        # A text string or an ordered list of text, image, and JSON parts.
        #
        # @see OpenAI::Models::DecisionInputMessage::User#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessage::User::Content::DecisionInputPartArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputText, OpenAI::Models::DecisionInputImage, OpenAI::Models::DecisionInputJSON>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputPartArray = OpenAI::Internal::Type::ArrayOf[union: -> { OpenAI::DecisionInputPart }]
        end

        # @see OpenAI::Models::DecisionInputMessage::User#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      class Developer < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   A text string or an ordered list of input text parts.
        #
        #   @return [String, Array<OpenAI::Models::DecisionInputText>]
        required :content, union: -> { OpenAI::DecisionInputMessage::Developer::Content }

        # @!attribute role
        #
        #   @return [Symbol, :developer]
        required :role, const: :developer

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessage::Developer::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessage::Developer::Type }

        # @!method initialize(content:, type: nil, role: :developer)
        #   A developer message containing input text.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputText>]
        #     A text string or an ordered list of input text parts.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessage::Developer::Type]
        #
        #   @param role [Symbol, :developer]

        # A text string or an ordered list of input text parts.
        #
        # @see OpenAI::Models::DecisionInputMessage::Developer#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessage::Developer::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputText }]
        end

        # @see OpenAI::Models::DecisionInputMessage::Developer#type
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
        required :content, union: -> { OpenAI::DecisionInputMessage::System::Content }

        # @!attribute role
        #
        #   @return [Symbol, :system]
        required :role, const: :system

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessage::System::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessage::System::Type }

        # @!method initialize(content:, type: nil, role: :system)
        #   A system message containing input text.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputText>]
        #     A text string or an ordered list of input text parts.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessage::System::Type]
        #
        #   @param role [Symbol, :system]

        # A text string or an ordered list of input text parts.
        #
        # @see OpenAI::Models::DecisionInputMessage::System#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessage::System::Content::DecisionInputTextArray }

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputText>)]

          # @type [OpenAI::Internal::Type::Converter]
          DecisionInputTextArray = OpenAI::Internal::Type::ArrayOf[-> { OpenAI::DecisionInputText }]
        end

        # @see OpenAI::Models::DecisionInputMessage::System#type
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
        #   @return [String, Array<OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::Refusal>]
        required :content, union: -> { OpenAI::DecisionInputMessage::Assistant::Content }

        # @!attribute role
        #
        #   @return [Symbol, :assistant]
        required :role, const: :assistant

        # @!attribute phase
        #   The phase of an assistant message.
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessage::Assistant::Phase, nil]
        optional :phase, enum: -> { OpenAI::DecisionInputMessage::Assistant::Phase }, nil?: true

        # @!attribute type
        #
        #   @return [Symbol, OpenAI::Models::DecisionInputMessage::Assistant::Type, nil]
        optional :type, enum: -> { OpenAI::DecisionInputMessage::Assistant::Type }

        # @!method initialize(content:, phase: nil, type: nil, role: :assistant)
        #   An assistant message containing output text or refusals.
        #
        #   @param content [String, Array<OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::Refusal>]
        #     A text string or an ordered list of output text and refusal parts.
        #
        #   @param phase [Symbol, OpenAI::Models::DecisionInputMessage::Assistant::Phase, nil]
        #     The phase of an assistant message.
        #
        #   @param type [Symbol, OpenAI::Models::DecisionInputMessage::Assistant::Type]
        #
        #   @param role [Symbol, :assistant]

        # A text string or an ordered list of output text and refusal parts.
        #
        # @see OpenAI::Models::DecisionInputMessage::Assistant#content
        module Content
          extend OpenAI::Internal::Type::Union

          variant String

          variant -> { OpenAI::Models::DecisionInputMessage::Assistant::Content::PartsArray }

          module Part
            extend OpenAI::Internal::Type::Union

            discriminator :type

            variant :output_text, -> { OpenAI::DecisionInputMessage::Assistant::Content::Part::OutputText }

            variant :refusal, -> { OpenAI::DecisionInputMessage::Assistant::Content::Part::Refusal }

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
            #   @return [Array(OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::Refusal)]
          end

          # @!method self.variants
          #   @return [Array(String, Array<OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::OutputText, OpenAI::Models::DecisionInputMessage::Assistant::Content::Part::Refusal>)]

          # @type [OpenAI::Internal::Type::Converter]
          PartsArray = OpenAI::Internal::Type::ArrayOf[
            union: -> { OpenAI::DecisionInputMessage::Assistant::Content::Part }
          ]
        end

        # The phase of an assistant message.
        #
        # @see OpenAI::Models::DecisionInputMessage::Assistant#phase
        module Phase
          extend OpenAI::Internal::Type::Enum

          COMMENTARY = :commentary
          FINAL_ANSWER = :final_answer

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::DecisionInputMessage::Assistant#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end

      # @!method self.variants
      #   @return [Array(OpenAI::Models::DecisionInputMessage::User, OpenAI::Models::DecisionInputMessage::Developer, OpenAI::Models::DecisionInputMessage::System, OpenAI::Models::DecisionInputMessage::Assistant)]
    end
  end
end
