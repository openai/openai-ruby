# frozen_string_literal: true

module OpenAI
  # @private
  #
  # @example
  # ```ruby
  # stream.for_each do |message|
  #   puts(message)
  # end
  # ```
  #
  # @example
  # ```ruby
  # messages = stream.to_enum.take(2)
  #
  # messages => Array
  # ```
  class Stream
    include OpenAI::BaseStream

    # @private
    #
    # @return [Enumerable]
    #
    private def iterator
      # rubocop:disable Metrics/BlockLength
      @iterator ||= OpenAI::Util.chain_fused(@messages) do |y|
        consume = false

        @messages.each do |msg|
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
              OpenAI::APIError.for(
                url: @url,
                status: @status,
                body: body,
                request: nil,
                response: @response,
                message: message
              )
            in decoded
              y << OpenAI::Converter.coerce(@model, decoded)
            end
          else
          end
        end
      end
      # rubocop:enable Metrics/BlockLength
    end
  end
end
