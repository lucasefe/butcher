require_relative 'client'
require 'json'

module Butcher
  module Service

    def initialize
      check!
    end

    def collection
      response = client.get(collection_path)
      build_collection(response)
    end

    def path
      raise NotImplementedError
    end

    def collection_path
      path
    end

    def source
      raise NotImplementedError
    end

    private

    def parse_json(data)
      JSON.parse(data)
    end

    def check!
      !source.nil? && !path.nil?
    end

    def client
      @client ||= Client.new(source)
    end

  end
end
