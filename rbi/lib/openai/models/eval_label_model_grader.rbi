# typed: strong

module OpenAI
  module Models
    class EvalLabelModelGrader < OpenAI::Internal::Type::BaseModel
      sig do
        returns(
          T::Array[
            T.any(
              OpenAI::Models::EvalLabelModelGrader::Input::Assistant,
              OpenAI::Models::EvalLabelModelGrader::Input::InputMessage
            )
          ]
        )
      end
      attr_accessor :input

      # The labels to assign to each item in the evaluation.
      sig { returns(T::Array[String]) }
      attr_accessor :labels

      # The model to use for the evaluation. Must support structured outputs.
      sig { returns(String) }
      attr_accessor :model

      # The name of the grader.
      sig { returns(String) }
      attr_accessor :name

      # The labels that indicate a passing result. Must be a subset of labels.
      sig { returns(T::Array[String]) }
      attr_accessor :passing_labels

      # The object type, which is always `label_model`.
      sig { returns(Symbol) }
      attr_accessor :type

      # A LabelModelGrader object which uses a model to assign labels to each item in
      # the evaluation.
      sig do
        params(
          input: T::Array[
            T.any(
              OpenAI::Models::EvalLabelModelGrader::Input::Assistant,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::EvalLabelModelGrader::Input::InputMessage
            )
          ],
          labels: T::Array[String],
          model: String,
          name: String,
          passing_labels: T::Array[String],
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(input:, labels:, model:, name:, passing_labels:, type: :label_model); end

      sig do
        override
          .returns(
            {
              input: T::Array[
                T.any(
                  OpenAI::Models::EvalLabelModelGrader::Input::Assistant,
                  OpenAI::Models::EvalLabelModelGrader::Input::InputMessage
                )
              ],
              labels: T::Array[String],
              model: String,
              name: String,
              passing_labels: T::Array[String],
              type: Symbol
            }
          )
      end
      def to_hash; end

      # An item can either be an input message or an output message.
      module Input
        extend OpenAI::Internal::Type::Union

        class InputMessage < OpenAI::Internal::Type::BaseModel
          sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content) }
          attr_reader :content

          sig do
            params(
              content: T.any(OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :content

          # The role of the message. One of `user`, `system`, or `developer`.
          sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol) }
          attr_accessor :role

          # The type of item, which is always `message`.
          sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type::TaggedSymbol) }
          attr_accessor :type

          sig do
            params(
              content: T.any(OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content, OpenAI::Internal::AnyHash),
              role: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::OrSymbol,
              type: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(content:, role:, type:); end

          sig do
            override
              .returns(
                {
                  content: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content,
                  role: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol,
                  type: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type::TaggedSymbol
                }
              )
          end
          def to_hash; end

          class Content < OpenAI::Internal::Type::BaseModel
            # The text content.
            sig { returns(String) }
            attr_accessor :text

            # The type of content, which is always `input_text`.
            sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type::TaggedSymbol) }
            attr_accessor :type

            sig do
              params(
                text: String,
                type: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(text:, type:); end

            sig do
              override
                .returns(
                  {text: String, type: OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type::TaggedSymbol}
                )
            end
            def to_hash; end

            # The type of content, which is always `input_text`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type) }
              OrSymbol =
                T.type_alias do
                  T.any(
                    Symbol,
                    String,
                    OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type::TaggedSymbol
                  )
                end

              INPUT_TEXT =
                T.let(:input_text, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type::TaggedSymbol)

              sig do
                override
                  .returns(T::Array[OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Content::Type::TaggedSymbol])
              end
              def self.values; end
            end
          end

          # The role of the message. One of `user`, `system`, or `developer`.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol) }

            USER = T.let(:user, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol)
            SYSTEM = T.let(:system, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol)
            DEVELOPER =
              T.let(:developer, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Role::TaggedSymbol]) }
            def self.values; end
          end

          # The type of item, which is always `message`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type::TaggedSymbol) }

            MESSAGE = T.let(:message, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::EvalLabelModelGrader::Input::InputMessage::Type::TaggedSymbol]) }
            def self.values; end
          end
        end

        class Assistant < OpenAI::Internal::Type::BaseModel
          sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content) }
          attr_reader :content

          sig do
            params(
              content: T.any(OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content, OpenAI::Internal::AnyHash)
            )
              .void
          end
          attr_writer :content

          # The role of the message. Must be `assistant` for output.
          sig { returns(Symbol) }
          attr_accessor :role

          # The type of item, which is always `message`.
          sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type::TaggedSymbol) }
          attr_accessor :type

          sig do
            params(
              content: T.any(OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content, OpenAI::Internal::AnyHash),
              type: OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type::OrSymbol,
              role: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(content:, type:, role: :assistant); end

          sig do
            override
              .returns(
                {
                  content: OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content,
                  role: Symbol,
                  type: OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type::TaggedSymbol
                }
              )
          end
          def to_hash; end

          class Content < OpenAI::Internal::Type::BaseModel
            # The text content.
            sig { returns(String) }
            attr_accessor :text

            # The type of content, which is always `output_text`.
            sig { returns(OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type::TaggedSymbol) }
            attr_accessor :type

            sig do
              params(
                text: String,
                type: OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(text:, type:); end

            sig do
              override
                .returns(
                  {text: String, type: OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type::TaggedSymbol}
                )
            end
            def to_hash; end

            # The type of content, which is always `output_text`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type) }
              OrSymbol =
                T.type_alias { T.any(Symbol, String, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type::TaggedSymbol) }

              OUTPUT_TEXT =
                T.let(:output_text, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type::TaggedSymbol)

              sig do
                override
                  .returns(T::Array[OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Content::Type::TaggedSymbol])
              end
              def self.values; end
            end
          end

          # The type of item, which is always `message`.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias { T.all(Symbol, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type) }
            OrSymbol =
              T.type_alias { T.any(Symbol, String, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type::TaggedSymbol) }

            MESSAGE = T.let(:message, OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::EvalLabelModelGrader::Input::Assistant::Type::TaggedSymbol]) }
            def self.values; end
          end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::EvalLabelModelGrader::Input::Assistant, OpenAI::Models::EvalLabelModelGrader::Input::InputMessage]
            )
        end
        def self.variants; end
      end
    end
  end
end
