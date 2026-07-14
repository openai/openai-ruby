# typed: strong

module OpenAI
  module Models
    BetaResponseTextDoneEvent = Beta::BetaResponseTextDoneEvent

    module Beta
      class BetaResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part that the text content is finalized.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the output item that the text content is finalized.
        sig { returns(String) }
        attr_accessor :item_id

        # The log probabilities of the tokens in the delta.
        sig do
          returns(T::Array[OpenAI::Beta::BetaResponseTextDoneEvent::Logprob])
        end
        attr_accessor :logprobs

        # The index of the output item that the text content is finalized.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The text content that is finalized.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `response.output_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseTextDoneEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseTextDoneEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Emitted when text content is finalized.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            logprobs:
              T::Array[
                OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::OrHash
              ],
            output_index: Integer,
            sequence_number: Integer,
            text: String,
            agent:
              T.nilable(OpenAI::Beta::BetaResponseTextDoneEvent::Agent::OrHash),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that the text content is finalized.
          content_index:,
          # The ID of the output item that the text content is finalized.
          item_id:,
          # The log probabilities of the tokens in the delta.
          logprobs:,
          # The index of the output item that the text content is finalized.
          output_index:,
          # The sequence number for this event.
          sequence_number:,
          # The text content that is finalized.
          text:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.output_text.done`.
          type: :"response.output_text.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              item_id: String,
              logprobs:
                T::Array[OpenAI::Beta::BetaResponseTextDoneEvent::Logprob],
              output_index: Integer,
              sequence_number: Integer,
              text: String,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseTextDoneEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseTextDoneEvent::Logprob,
                OpenAI::Internal::AnyHash
              )
            end

          # A possible text token.
          sig { returns(String) }
          attr_accessor :token

          # The log probability of this token.
          sig { returns(Float) }
          attr_accessor :logprob

          # The log probabilities of up to 20 of the most likely tokens.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob
                ]
              )
            )
          end
          attr_reader :top_logprobs

          sig do
            params(
              top_logprobs:
                T::Array[
                  OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob::OrHash
                ]
            ).void
          end
          attr_writer :top_logprobs

          # A logprob is the logarithmic probability that the model assigns to producing a
          # particular token at a given position in the sequence. Less-negative (higher)
          # logprob values indicate greater model confidence in that token choice.
          sig do
            params(
              token: String,
              logprob: Float,
              top_logprobs:
                T::Array[
                  OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob::OrHash
                ]
            ).returns(T.attached_class)
          end
          def self.new(
            # A possible text token.
            token:,
            # The log probability of this token.
            logprob:,
            # The log probabilities of up to 20 of the most likely tokens.
            top_logprobs: nil
          )
          end

          sig do
            override.returns(
              {
                token: String,
                logprob: Float,
                top_logprobs:
                  T::Array[
                    OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob
                  ]
              }
            )
          end
          def to_hash
          end

          class TopLogprob < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::TopLogprob,
                  OpenAI::Internal::AnyHash
                )
              end

            # A possible text token.
            sig { returns(T.nilable(String)) }
            attr_reader :token

            sig { params(token: String).void }
            attr_writer :token

            # The log probability of this token.
            sig { returns(T.nilable(Float)) }
            attr_reader :logprob

            sig { params(logprob: Float).void }
            attr_writer :logprob

            sig do
              params(token: String, logprob: Float).returns(T.attached_class)
            end
            def self.new(
              # A possible text token.
              token: nil,
              # The log probability of this token.
              logprob: nil
            )
            end

            sig { override.returns({ token: String, logprob: Float }) }
            def to_hash
            end
          end
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseTextDoneEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
