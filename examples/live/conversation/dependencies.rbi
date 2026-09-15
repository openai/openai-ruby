# typed: false

# Optional dependency declarations used only by the examples Sorbet check,
# which intentionally skips gem RBIs. These are not SDK APIs.
module Async
  class Task
    def self.current
    end

    def with_timeout(duration, &block)
    end
  end

  module HTTP
    class Endpoint
      def self.parse(string, **options)
      end
    end

    class Server
      def initialize(app, endpoint)
      end

      def run
      end
    end
  end
end

module Protocol
  module HTTP
    class Response
      def self.[](status, headers = {}, body = nil)
      end
    end
  end
end
