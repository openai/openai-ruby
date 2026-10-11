# typed: strong

module OpenAI
  module Resources

    class Decisions

      # Use this endpoint to ask classification or scoring questions about the same
      # input. You’ll get the answers back in the order you asked the questions.
      #
      # For text, you can pass a string. You can also send user messages containing
      # `input_text` and `input_image` parts, with up to 128 images per request. Images
      # must be data URLs; external URLs and file IDs aren’t accepted. Other message
      # roles, function calls, files, audio, and item references aren’t supported.
      #
      # Sometimes a question returns a refusal instead of an answer. The result has type
      # `refusal` and includes the question’s name, or `null` if you didn’t give it one.
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
        # messages containing text and inline images. Images must be inline data URLs; at
        # most 128 images are allowed across all messages in one request. External URLs,
        # files, audio, tools, and item references are not supported.
        input:,
        model:,
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
