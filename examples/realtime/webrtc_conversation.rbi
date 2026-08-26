# typed: true

# Repository typechecking deliberately skips dependency RBIs. Keep this small
# optional async-http boundary local to the example rather than shipping it as
# part of the SDK's public signatures.
module Async
  module HTTP
    class Endpoint
      def self.parse(origin)
      end
    end

    class Server
      def initialize(application, endpoint, protocol: nil)
      end

      def run
      end
    end

    module Protocol
      module HTTP1
        class Server
          def initialize(stream, version, **options)
          end

          def read_request_line
          end

          def read_headers
          end

          def next_request
          end

          def write_response(version, status, headers)
          end

          def write_body(version, body)
          end
        end
      end
    end
  end
end

module Protocol
  module HTTP
    class Response
      def self.[](status, headers, body)
      end
    end

    class DuplicateHeaderError < StandardError
    end
  end

  module HTTP1
    class BadRequest < StandardError
    end
  end
end
