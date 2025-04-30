# typed: strong

module OpenAI
  module Internal
    module Type
      # @api private
      module RequestParameters
        # Options to specify HTTP behaviour for this request.
        sig { returns(OpenAI::RequestOpts) }
        attr_accessor :request_options

        # @api private
        module Converter
          # @api private
          sig { params(params: T.anything).returns([T.anything, OpenAI::Internal::AnyHash]) }
          def dump_request(params); end
        end
      end
    end
  end
end
