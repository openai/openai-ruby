# frozen_string_literal: true

module OpenAI
  module Internal
    # @generic Elem
    #
    # @example
    #   stream.each do |event|
    #     puts(event)
    #   end
    class Stream
      include OpenAI::Internal::Type::BaseStream

      # @api private
      #
      # @return [Enumerable<generic<Elem>>]
      private def iterator
        # rubocop:disable Metrics/BlockLength
        @iterator ||= OpenAI::Internal::Util.chain_fused(@stream) do |y|
          consume = false

          @stream.each do |msg|
            next if consume

            case msg
            in { data: String => data } if data.start_with?("[DONE]")
              consume = true
              next
            in { data: String => data }
              case JSON.parse(data, symbolize_names: true)
              in { error: error }
                message =
                  case error
                  in String
                    error
                  in { message: String => m }
                    m
                  else
                    "An error occurred during streaming"
                  end
                OpenAI::Errors::APIError.for(
                  url: @url,
                  status: @status,
                  body: body,
                  request: nil,
                  response: @response,
                  message: message
                )
              in decoded
                y << OpenAI::Internal::Type::Converter.coerce(@model, decoded)
              end
            else
            end
          end
        end
        # rubocop:enable Metrics/BlockLength
      end
    end
  end
end
