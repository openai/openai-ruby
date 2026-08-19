# typed: strong

module OpenAI
  module Models

    BetaResponseImageGenCallPartialImageEvent = Beta::BetaResponseImageGenCallPartialImageEvent

    module Beta

      class BetaResponseImageGenCallPartialImageEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The unique identifier of the image generation item being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # Base64-encoded partial image data, suitable for rendering as an image.
        sig { returns(String) }
        attr_accessor :partial_image_b64

        # 0-based index for the partial image (backend is 1-based, but this is 0-based for
        # the user).
        sig { returns(Integer) }
        attr_accessor :partial_image_index

        # The sequence number of the image generation item being processed.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.image_generation_call.partial_image'.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent)) }
        attr_reader :agent

        sig { params(agent: T.nilable(OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent::OrHash)).void }
        attr_writer :agent

        # The background setting that was used.
        sig { returns(T.nilable(String)) }
        attr_reader :background

        sig { params(background: String).void }
        attr_writer :background

        # The output format that was used.
        sig { returns(T.nilable(String)) }
        attr_reader :output_format

        sig { params(output_format: String).void }
        attr_writer :output_format

        # The image quality that was used.
        sig { returns(T.nilable(String)) }
        attr_reader :quality

        sig { params(quality: String).void }
        attr_writer :quality

        # The image size that was used.
        sig { returns(T.nilable(String)) }
        attr_reader :size

        sig { params(size: String).void }
        attr_writer :size

        # Emitted when a partial image is available during image generation streaming.
        sig do
          params(

            item_id: String,

            output_index: Integer,

            partial_image_b64: String,

            partial_image_index: Integer,

            sequence_number: Integer,

            agent: T.nilable(OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent::OrHash),

            background: String,

            output_format: String,

            quality: String,

            size: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The unique identifier of the image generation item being processed.
          item_id:,

          # The index of the output item in the response's output array.
          output_index:,

          # Base64-encoded partial image data, suitable for rendering as an image.
          partial_image_b64:,

          # 0-based index for the partial image (backend is 1-based, but this is 0-based for
          # the user).
          partial_image_index:,

          # The sequence number of the image generation item being processed.
          sequence_number:,

          # The agent that owns this multi-agent streaming event.
          agent: nil,

          # The background setting that was used.
          background: nil,

          # The output format that was used.
          output_format: nil,

          # The image quality that was used.
          quality: nil,

          # The image size that was used.
          size: nil,

          # The type of the event. Always 'response.image_generation_call.partial_image'.

          type: :"response.image_generation_call.partial_image"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              partial_image_b64: String,
              partial_image_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent: T.nilable(OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent),
              background: String,
              output_format: String,
              quality: String,
              size: String
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent,
              OpenAI::Internal::AnyHash
            )
          end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig do
            params(

              agent_name: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The canonical name of the agent that produced this item.

            agent_name:
          )
          end

          sig do
            override.returns(
              {agent_name: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
