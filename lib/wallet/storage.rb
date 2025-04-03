module Wallet
  module Storage
    extend self

    KEY_FILE_SRC = File.join(File.dirname(__FILE__), '/storage/private_key').freeze

    def get_key
      File.exist?(KEY_FILE_SRC) ? File.read(KEY_FILE_SRC) : nil
    end

    def put_key(private_key = nil)
      File.write(KEY_FILE_SRC, private_key)
      private_key
    end

    def has_key?
      !get_key.nil?
    end
  end
end
