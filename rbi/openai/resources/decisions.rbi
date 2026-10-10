# typed: strong

module OpenAI
  module Resources

    class Decisions

      # Evaluate ordered classification and scoring questions against shared input.
      # Answers are returned in question order.
      #
      # Supply input as a string or user messages containing text and inline images.
      # Only user messages with `input_text` and `input_image` parts are supported;
      # non-user roles, function calls, files, audio, and item references are not
      # supported. Images require a data URL, not an external URL or file ID. At most
      # 128 images are allowed across the request.
      #
      # Each question can return a refusal instead of a scored answer. A refusal has
      # type `refusal` and the corresponding question name, or null if unnamed.
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
