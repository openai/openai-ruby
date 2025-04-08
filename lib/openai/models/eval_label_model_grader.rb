# frozen_string_literal: true

module OpenAI
  module Models
    class EvalLabelModelGrader < OpenAI::Internal::Type::BaseModel
      # @!attribute input
      #
      #   @return [Array<OpenAI::Models::EvalLabelModelGrader::Input::Assistant, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage>]
      required :input,
               -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::EvalLabelModelGrader::Input] }

      # @!attribute labels
      #   The labels to assign to each item in the evaluation.
      #
      #   @return [Array<String>]
      required :labels, OpenAI::Internal::Type::ArrayOf[String]

      # @!attribute model
      #   The model to use for the evaluation. Must support structured outputs.
      #
      #   @return [String]
      required :model, String

      # @!attribute name
      #   The name of the grader.
      #
      #   @return [String]
      required :name, String

      # @!attribute passing_labels
      #   The labels that indicate a passing result. Must be a subset of labels.
      #
      #   @return [Array<String>]
      required :passing_labels, OpenAI::Internal::Type::ArrayOf[String]

      # @!attribute type
      #   The object type, which is always `label_model`.
      #
      #   @return [Symbol, :label_model]
      required :type, const: :label_model

      # @!parse
      #   # A LabelModelGrader object which uses a model to assign labels to each item in
      #   # the evaluation.
      #   #
      #   # @param input [Array<OpenAI::Models::EvalLabelModelGrader::Input::Assistant, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage>]
      #   # @param labels [Array<String>]
      #   # @param model [String]
      #   # @param name [String]
      #   # @param passing_labels [Array<String>]
      #   # @param type [Symbol, :label_model]
      #   #
      #   def initialize(input:, labels:, model:, name:, passing_labels:, type: :label_model, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # An item can either be an input message or an output message.
      module Input
        extend OpenAI::Internal::Type::Union

        discriminator :role

        variant :assistant, -> { OpenAI::Models::EvalLabelModelGrader::Input::Assistant }

        variant -> { OpenAI::Models::EvalLabelModelGrader::Input::InputMessage }

        class InputMessage < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #
          #   @return [OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content]
          required :content, -> { OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content }

          # @!attribute role
          #   The role of the message. One of `user`, `system`, or `developer`.
          #
          #   @return [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role]
          required :role, enum: -> { OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role }

          # @!attribute type
          #   The type of item, which is always `message`.
          #
          #   @return [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type]
          required :type, enum: -> { OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type }

          # @!parse
          #   # @param content [OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content]
          #   # @param role [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role]
          #   # @param type [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type]
          #   #
          #   def initialize(content:, role:, type:, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::EvalLabelModelGrader::Input::InputMessage#content
          class Content < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The text content.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   The type of content, which is always `input_text`.
            #
            #   @return [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type]
            required :type, enum: -> { OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type }

            # @!parse
            #   # @param text [String]
            #   # @param type [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type]
            #   #
            #   def initialize(text:, type:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # The type of content, which is always `input_text`.
            #
            # @see OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content#type
            module Type
              extend OpenAI::Internal::Type::Enum

              INPUT_TEXT = :input_text

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end
          end

          # The role of the message. One of `user`, `system`, or `developer`.
          #
          # @see OpenAI::Models::EvalLabelModelGrader::Input::InputMessage#role
          module Role
            extend OpenAI::Internal::Type::Enum

            USER = :user
            SYSTEM = :system
            DEVELOPER = :developer

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end

          # The type of item, which is always `message`.
          #
          # @see OpenAI::Models::EvalLabelModelGrader::Input::InputMessage#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end

        class Assistant < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #
          #   @return [OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content]
          required :content, -> { OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content }

          # @!attribute role
          #   The role of the message. Must be `assistant` for output.
          #
          #   @return [Symbol, :assistant]
          required :role, const: :assistant

          # @!attribute type
          #   The type of item, which is always `message`.
          #
          #   @return [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type]
          required :type, enum: -> { OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type }

          # @!parse
          #   # @param content [OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content]
          #   # @param type [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type]
          #   # @param role [Symbol, :assistant]
          #   #
          #   def initialize(content:, type:, role: :assistant, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::EvalLabelModelGrader::Input::Assistant#content
          class Content < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The text content.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   The type of content, which is always `output_text`.
            #
            #   @return [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type]
            required :type, enum: -> { OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type }

            # @!parse
            #   # @param text [String]
            #   # @param type [Symbol, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type]
            #   #
            #   def initialize(text:, type:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # The type of content, which is always `output_text`.
            #
            # @see OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content#type
            module Type
              extend OpenAI::Internal::Type::Enum

              OUTPUT_TEXT = :output_text

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end
          end

          # The type of item, which is always `message`.
          #
          # @see OpenAI::Models::EvalLabelModelGrader::Input::Assistant#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end

        # @!parse
        #   # @return [Array(OpenAI::Models::EvalLabelModelGrader::Input::Assistant, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage)]
        #   def self.variants; end
      end
    end
  end
end
