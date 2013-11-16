require_relative '../spec_helper'

include Butcher

describe Service do
  let(:service_class) do
    Class.new do
      include Service

      def path
        '/v1/beers'
      end

      def source
        'http://api.openbeerdatabase.com'
      end

      def build_collection(response)
        data = parse_json(response.body)
        data['beers']
      end
    end
  end

  context "when being defined" do

    it "should fail unless source and endpoint is provided" do
      invalid_service_class = Class.new do
        include Service
      end
      expect { invalid_service_class.new }.to raise_error(NotImplementedError)
    end

    it "should fail unless source and endpoint is provided" do
      expect { service_class.new }.to_not raise_error
    end

  end

  context "being used" do
    context "#collection" do

      it "" do
        service = service_class.new
        results = VCR.use_cassette('beers') do
          service.collection
        end

        expect(results).not_to be_nil
        expect(results).to be_an Array
      end

    end
  end
end
