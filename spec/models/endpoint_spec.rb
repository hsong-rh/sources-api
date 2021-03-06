describe Endpoint do
  describe "#base_url_path" do
    let(:endpoint) { described_class.new(:host => "www.example.com", :port => 1234, :scheme => "https") }

    it "combines the various attributes to create a full url" do
      expect(endpoint.base_url_path).to eq("https://www.example.com:1234")
    end
  end

  describe "#default" do
    let(:source_type) { SourceType.find_or_create_by!(:name => "amazon", :product_name => "Amazon Web Services", :vendor => "Amazon") }
    let(:tenant) { Tenant.create!(:external_tenant => SecureRandom.uuid) }
    let(:source) { Source.create!(:name => "my-source", :tenant => tenant, :source_type => source_type) }

    it "allows only one default endpoint" do
      described_class.create!(:role => "first", :default => true, :tenant => tenant, :source => source)
      expect { described_class.create!(:role => "second", :default => true, :tenant => tenant, :source => source) }.to raise_exception
    end
  end
end
