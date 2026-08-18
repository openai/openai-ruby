# typed: strong

module OpenAI
  module Models
    BetaResponseTextDeltaEvent = Beta::BetaResponseTextDeltaEvent

    module Beta
      class BetaResponseTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseTextDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part that the text delta was added to.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The text delta that was added.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the output item that the text delta was added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The log probabilities of the tokens in the delta.
        sig do
          returns(T::Array[OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob])
        end
        attr_accessor :logprobs

        # The index of the output item that the text delta was added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.output_text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseTextDeltaEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(OpenAI::Beta::BetaResponseTextDeltaEvent::Agent::OrHash)
          ).void
        end
        attr_writer :agent

        # Emitted when there is an additional text delta.
        sig do
          params(
            content_index: Integer,
            delta: String,
            item_id: String,
            logprobs:
              T::Array[
                OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::OrHash
              ],
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseTextDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that the text delta was added to.
          content_index:,
          # The text delta that was added.
          delta:,
          # The ID of the output item that the text delta was added to.
          item_id:,
          # The log probabilities of the tokens in the delta.
          logprobs:,
          # The index of the output item that the text delta was added to.
          output_index:,
          # The sequence number for this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.output_text.delta`.
          type: :"response.output_text.delta"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              delta: String,
              item_id: String,
              logprobs:
                T::Array[OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob],
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseTextDeltaEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob,
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
                  OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob
                ]
              )
            )
          end
          attr_reader :top_logprobs

          sig do
            params(
              top_logprobs:
                T::Array[
                  OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob::OrHash
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
                  OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob::OrHash
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
                    OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob
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
                  OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::TopLogprob,
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
                OpenAI::Beta::BetaResponseTextDeltaEvent::Agent,
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
