require 'rails_helper'

RSpec.describe GoogleSearchGateway do
  let(:valid_plant_data) do
    [
      { name: "Tomato", description: "A plant that thrives in full sun." },
      { name: "Zucchini", description: "Grows well in loamy soil." }
    ]
  end

  let(:stubbed_response) do
    {
      kind: "customsearch#search",
      items: [
        {
          link: "https://example.com/tomato.jpg",
          title: "Tomato - Wikipedia",
          snippet: "Tomato is a fruit from the nightshade family.",
          image: {
            contextLink: "https://en.wikipedia.org/wiki/Tomato"
          }
        }
      ]
    }.to_json
  end

  let(:empty_response) do
    {
      kind: "customsearch#search",
      items: []
    }.to_json
  end

  let(:gateway) { described_class.new }

  describe "#enrich_with_google_data" do
    it "enriches plant data with Google API results" do
      stub_request(:get, /www.googleapis.com\/customsearch\/v1/)
        .to_return(status: 200, body: stubbed_response, headers: { 'Content-Type' => 'application/json' })

      enriched_data = gateway.enrich_with_google_data(valid_plant_data)

      expect(enriched_data).to be_an Array
      expect(enriched_data[0][:image]).to eq("https://example.com/tomato.jpg")
      expect(enriched_data[0][:title]).to eq("Tomato - Wikipedia")
      expect(enriched_data[0][:snippet]).to eq("Tomato is a fruit from the nightshade family.")
      expect(enriched_data[0][:context_link]).to eq("https://en.wikipedia.org/wiki/Tomato")
    end

    it "skips plants with missing names" do
      invalid_plant_data = [{ description: "Missing name field." }]

      enriched_data = gateway.enrich_with_google_data(invalid_plant_data)

      expect(enriched_data).to eq(invalid_plant_data)
    end

    it "returns the original plant data if Google API returns no results" do
      stub_request(:get, /www.googleapis.com\/customsearch\/v1/)
        .to_return(status: 200, body: empty_response, headers: { 'Content-Type' => 'application/json' })

      enriched_data = gateway.enrich_with_google_data(valid_plant_data)

      expect(enriched_data).to eq(valid_plant_data)
    end

    it "handles errors gracefully" do
      stub_request(:get, /www.googleapis.com\/customsearch\/v1/)
        .to_raise(StandardError.new("Network error"))

      enriched_data = gateway.enrich_with_google_data(valid_plant_data)

      expect(enriched_data).to eq(valid_plant_data)
    end
  end

  describe "#fetch_google_data" do
    it "returns data for a valid query" do
      stub_request(:get, /www.googleapis.com\/customsearch\/v1/)
        .to_return(status: 200, body: stubbed_response, headers: { 'Content-Type' => 'application/json' })

      result = gateway.send(:fetch_google_data, "Tomato")

      expect(result).to eq({
        image: "https://example.com/tomato.jpg",
        title: "Tomato - Wikipedia",
        snippet: "Tomato is a fruit from the nightshade family.",
        context_link: "https://en.wikipedia.org/wiki/Tomato"
      })
    end

    it "returns nil for an empty response" do
      stub_request(:get, /www.googleapis.com\/customsearch\/v1/)
        .to_return(status: 200, body: empty_response, headers: { 'Content-Type' => 'application/json' })

      result = gateway.send(:fetch_google_data, "Nonexistent Plant")

      expect(result).to be_nil
    end

    it "returns nil for an API error" do
      stub_request(:get, /www.googleapis.com\/customsearch\/v1/)
        .to_return(status: 500)

      result = gateway.send(:fetch_google_data, "Tomato")

      expect(result).to be_nil
    end
  end
end
