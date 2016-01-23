require 'spec_helper'

describe RHapi::Contact do
  before :all do
    config_demo_api
  end

  describe "create" do
    it "should create the company", :vcr do
      c = RHapi::Company.create(name: "A company name")

      expect(c.companyId).to_not be_nil
    end
  end
  
  describe "find_by_company_id", :vcr do
    it "should be able to find the company by HubSpot ID value" do
      c = RHapi::Company.create(name: "Example Inc")

      c2 = RHapi::Company.find_by_company_id(c.companyId)
      expect(c2.properties.name).to eq("Example Inc")
    end
  end
  
  describe "update", :vcr do
    it "should update the company details" do
      c = RHapi::Company.create(name: "Company ABC")
      c.update(name: "Example Inc")
      
      c2 = RHapi::Company.find_by_company_id(c.companyId)
      expect(c2.properties.name).to eq("Example Inc")
    end
  end
end