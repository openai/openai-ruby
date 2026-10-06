# typed: strong

module OpenAI
  module Models

    class DecisionCreateParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionCreateParams,
          OpenAI::Internal::AnyHash
        )
      end

      # Shared evidence, as a string or an array of user messages containing text and
      # inline images. Non-user roles, function calls, function-call outputs, files,
      # audio, and item references are not supported. At most 128 image parts are
      # allowed across all messages in one request.
      sig { returns(OpenAI::DecisionCreateParams::Input::Variants) }
      attr_accessor :input

      sig { returns(String) }
      attr_accessor :model

      sig {
        returns(
          T::Array[
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate,
              OpenAI::DecisionCreateParams::Question::Choice,
              OpenAI::DecisionCreateParams::Question::Score
            )
          ]
        )
      }
      attr_accessor :questions

      # Opaque caller-provided end-user identifier, scoped by the verified org. Match
      # Responses' limit; this is never the authenticated user identity.
      sig { returns(T.nilable(String)) }
      attr_accessor :safety_identifier

      sig do
        params(

          input: OpenAI::DecisionCreateParams::Input::Variants,

          model: String,

          questions: T::Array[
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate::OrHash,
              OpenAI::DecisionCreateParams::Question::Choice::OrHash,
              OpenAI::DecisionCreateParams::Question::Score::OrHash
            )
          ],

          safety_identifier: T.nilable(String),

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # Shared evidence, as a string or an array of user messages containing text and
        # inline images. Non-user roles, function calls, function-call outputs, files,
        # audio, and item references are not supported. At most 128 image parts are
        # allowed across all messages in one request.
        input:,

        model:,

        questions:,

        # Opaque caller-provided end-user identifier, scoped by the verified org. Match
        # Responses' limit; this is never the authenticated user identity.
        safety_identifier: nil,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            input: OpenAI::DecisionCreateParams::Input::Variants,
            model: String,
            questions: T::Array[
              T.any(
                OpenAI::DecisionCreateParams::Question::Predicate,
                OpenAI::DecisionCreateParams::Question::Choice,
                OpenAI::DecisionCreateParams::Question::Score
              )
            ],
            safety_identifier: T.nilable(String),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Shared evidence, as a string or an array of user messages containing text and
      # inline images. Non-user roles, function calls, function-call outputs, files,
      # audio, and item references are not supported. At most 128 image parts are
      # allowed across all messages in one request.
      module Input
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputMessage]) }

        sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Input::Variants]) }
        def self.variants
        end

        DecisionInputMessageArray = T.let(
          OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputMessage],
          OpenAI::Internal::Type::Converter
        )

      end

      # A question about the request's input, with an optional correlation name.
      module Question
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(
            OpenAI::DecisionCreateParams::Question::Predicate,
            OpenAI::DecisionCreateParams::Question::Choice,
            OpenAI::DecisionCreateParams::Question::Score
          )
        }

        class Predicate < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :instructions

          # The type of the object. Always `predicate`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              instructions: String,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            name: nil,

            # The type of the object. Always `predicate`.

            type: :predicate
          )
          end

          sig do
            override.returns(
              {instructions: String, type: Symbol, name: String}
            )
          end
          def to_hash
          end

        end

        class Choice < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Choice,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice]) }
          attr_accessor :choices

          sig { returns(String) }
          attr_accessor :instructions

          # The type of the object. Always `choice`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              choices: T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice::OrHash],

              instructions: String,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            choices:,

            instructions:,

            name: nil,

            # The type of the object. Always `choice`.

            type: :choice
          )
          end

          sig do
            override.returns(
              {
                choices: T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice],
                instructions: String,
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          class Choice < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Question::Choice::Choice,
                OpenAI::Internal::AnyHash
              )
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            sig { returns(T.any(String, T::Boolean)) }
            attr_accessor :value

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig do
              params(

                value: T.any(String, T::Boolean),

                description: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Choice values are typed: a string and a boolean with the same text are distinct.
              value:,

              description: nil
            )
            end

            sig do
              override.returns(
                {value: T.any(String, T::Boolean), description: String}
              )
            end
            def to_hash
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            module Value
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Boolean) }

              sig {
                override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice::Value::Variants])
              }
              def self.variants
              end

            end
          end
        end

        class Score < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Score,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(String) }
          attr_accessor :instructions

          sig { returns(T::Array[OpenAI::DecisionCreateParams::Question::Score::Level]) }
          attr_accessor :levels

          # The type of the object. Always `score`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              instructions: String,

              levels: T::Array[OpenAI::DecisionCreateParams::Question::Score::Level::OrHash],

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            levels:,

            name: nil,

            # The type of the object. Always `score`.

            type: :score
          )
          end

          sig do
            override.returns(
              {
                instructions: String,
                levels: T::Array[OpenAI::DecisionCreateParams::Question::Score::Level],
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          class Level < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Question::Score::Level,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :label

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig do
              params(

                label: String,

                description: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              label:,

              description: nil
            )
            end

            sig do
              override.returns(
                {label: String, description: String}
              )
            end
            def to_hash
            end

          end
        end

        sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Variants]) }
        def self.variants
        end

      end

    end

  end
end
