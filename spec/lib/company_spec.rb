require 'spec_helper'

describe RHapi::Contact, :vcr do
  before :all do
    config_demo_api
  end

  describe "create" do
    it "should create the company" do
      c = RHapi::Company.create(name: "A company name")

      expect(c.companyId).to_not be_nil
    end
  end
  
  describe "find_by_company_id" do
    it "should be able to find the company by HubSpot ID value" do
      c = RHapi::Company.create(name: "Example Inc")

      c2 = RHapi::Company.find_by_company_id(c.companyId)
      expect(c2.properties.name).to eq("Example Inc")
    end
  end
  
  describe "update" do
    it "should update the company details" do
      c = RHapi::Company.create(name: "Company ABC")
      c.update(name: "Example Inc")
      
      c2 = RHapi::Company.find_by_company_id(c.companyId)
      expect(c2.properties.name).to eq("Example Inc")
    end
  end
  
  describe "connect to contact" do
    it "should connect the contact to the company" do
      company = RHapi::Company.create(name: "A company name")
      expect(company.companyId).to_not be_nil
    
      begin
        RHapi::Contact.create(email: "bob@smith.com")
      rescue
      end
        
      contact = RHapi::Contact.find_by_email("bob@smith.com")
    
      company.connect_contact(contact.vid)
      
      result = RHapi::Company.all_company_contacts(company.companyId)
      expect(result["contacts"][0]["vid"]).to eq(contact.vid)
    end
  end
end