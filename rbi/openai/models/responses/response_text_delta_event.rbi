# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseTextDeltaEvent,
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
          returns(T::Array[OpenAI::Responses::ResponseTextDeltaEvent::Logprob])
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

        # Emitted when there is an additional text delta.
        sig do
          params(
            content_index: Integer,
            delta: String,
            item_id: String,
            logprobs:
              T::Array[
                OpenAI::Responses::ResponseTextDeltaEvent::Logprob::OrHash
              ],
            output_index: Integer,
            sequence_number: Integer,
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
                T::Array[OpenAI::Responses::ResponseTextDeltaEvent::Logprob],
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseTextDeltaEvent::Logprob,
                OpenAI::Internal::AnyHash
              )
            end

          # A possible text token.
          sig { returns(String) }
          attr_accessor :token

          # The log probability of this token.
          sig { returns(Float) }
          attr_accessor :logprob

          # The log probability of the top 20 most likely tokens.
          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Responses::ResponseTextDeltaEvent::Logprob::TopLogprob
                ]
              )
            )
          end
          attr_reader :top_logprobs

          sig do
            params(
              top_logprobs:
                T::Array[
                  OpenAI::Responses::ResponseTextDeltaEvent::Logprob::TopLogprob::OrHash
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
                  OpenAI::Responses::ResponseTextDeltaEvent::Logprob::TopLogprob::OrHash
                ]
            ).returns(T.attached_class)
          end
          def self.new(
            # A possible text token.
            token:,
            # The log probability of this token.
            logprob:,
            # The log probability of the top 20 most likely tokens.
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
                    OpenAI::Responses::ResponseTextDeltaEvent::Logprob::TopLogprob
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
                  OpenAI::Responses::ResponseTextDeltaEvent::Logprob::TopLogprob,
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
      end
    end
  end
end
