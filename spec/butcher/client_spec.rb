require_relative '../spec_helper'
require 'uri'

include Butcher

describe Client do

  let(:source)            { "someplace.ex" }
  let(:source_url)        { "http://#{source}" }
  let(:other_source)      { "2someplace.ex" }
  let(:other_source_url)  { "http://#{other_source}" }
  let(:common_response)   { { body: "abc", status: 200, headers: { 'Content-Length' => 3 } } }

  context "#get" do
    context "with a string path as param" do
      it "does a GET request" do
        stub_request(:get, source).to_return(common_response)
        response = Client.new(source_url).get("/")
        expect(response.body).to eq("abc")
        expect(response.headers).to eq({ 'Content-Length' => "3" })
      end
    end

    context "with a URI instace as param" do
      it "does a GET request (skipping source)" do
        stub_request(:get, other_source).to_return(common_response)

        uri = URI.parse(other_source_url)
        Client.new(source_url).get(uri)
      end
    end

    context "with a path that starts with http* as param" do
      it "does a GET request (skipping source)" do
        stub_request(:get, "lucas.com").to_return(common_response)
        Client.new(source_url).get("http://lucas.com")
      end
    end
  end
end
