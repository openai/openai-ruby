# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseTextDoneEvent,
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
          returns(T::Array[OpenAI::Responses::ResponseTextDoneEvent::Logprob])
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

        # Emitted when text content is finalized.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            logprobs:
              T::Array[
                OpenAI::Responses::ResponseTextDoneEvent::Logprob::OrHash
              ],
            output_index: Integer,
            sequence_number: Integer,
            text: String,
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
                T::Array[OpenAI::Responses::ResponseTextDoneEvent::Logprob],
              output_index: Integer,
              sequence_number: Integer,
              text: String,
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
                OpenAI::Responses::ResponseTextDoneEvent::Logprob,
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
                  OpenAI::Responses::ResponseTextDoneEvent::Logprob::TopLogprob
                ]
              )
            )
          end
          attr_reader :top_logprobs

          sig do
            params(
              top_logprobs:
                T::Array[
                  OpenAI::Responses::ResponseTextDoneEvent::Logprob::TopLogprob::OrHash
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
                  OpenAI::Responses::ResponseTextDoneEvent::Logprob::TopLogprob::OrHash
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
                    OpenAI::Responses::ResponseTextDoneEvent::Logprob::TopLogprob
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
                  OpenAI::Responses::ResponseTextDoneEvent::Logprob::TopLogprob,
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
