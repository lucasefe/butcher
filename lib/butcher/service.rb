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

    def resource(id)
      response = client.get(resource_path(id))
      build_resource(response)
    end

    private

    def build_resource(response)
      parse_json(response.body)
    end

    def build_collection(response)
      parse_json(response.body)
    end

    def parse_json(data)
      JSON.parse(data)
    end

    def check!
      !source.nil? && !path.nil?
    end

    def client
      @client ||= Client.new(source)
    end

    def path
      raise NotImplementedError
    end

    def collection_path
      path
    end

    def resource_path(id)
      File.join(path, id.to_s)
    end

    def source
      raise NotImplementedError
    end

  end
end
