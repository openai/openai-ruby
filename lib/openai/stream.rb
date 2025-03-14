# frozen_string_literal: true

module OpenAI
  # @example
  # ```ruby
  # stream.for_each do |event|
  #   puts(event)
  # end
  # ```
  #
  # @example
  # ```ruby
  # events = stream
  #   .to_enum
  #   .lazy
  #   .select { _1.object_id.even? }
  #   .map(&:itself)
  #   .take(2)
  #   .to_a
  #
  # events => Array
  # ```
  class Stream
    include OpenAI::BaseStream

    # @api private
    #
    # @return [Enumerable]
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
