require 'async/http/internet/instance'

module Wallet
  module Mempool
    class Client
      def get(uri)
        Sync do
          Async::HTTP::Internet
            .get(uri, headers, &:read)
            .then { |string| JSON.parse string }
        end
      end

      def post(uri, payload)
        Sync do
          response = Async::HTTP::Internet.post(uri, headers, payload)
          response.read
        ensure
          response.close
        end
      end

      def headers
        [%w[accept application/json]]
      end
    end
  end
end
