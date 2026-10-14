# typed: strong

module OpenAI
  module Resources

    class Decisions

      # Use this endpoint to quickly answer classification or scoring questions about
      # some input. You can ask multiple questions in one request.
      sig {
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
          .returns(OpenAI::Decision)
      }
      def create(
        # The text or images to evaluate for every question. Provide a text string or user
        # messages containing text and images. Images can be base64 data URLs or publicly
        # accessible HTTP(S) URLs; at most 128 images are allowed across all messages in
        # one request. Files, audio, tools, and item references are not supported.
        input:,
        # The model to use. Only `gpt-6-luna` is supported.
        model:,
        # Ask 1–200 questions about the input. Each question can be a predicate, choice,
        # or score. Answers come back in the same order.
        questions:,
        # Opaque caller-provided end-user identifier, scoped by the verified org. Match
        # Responses' limit; this is never the authenticated user identity.
        safety_identifier: nil,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end

  end
end
