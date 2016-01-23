require 'spec_helper'

describe RHapi::Contact do
  before :all do
    config_demo_api
  end

  describe "create" do
    it "should create the contact", :vcr do
      RHapi::Contact.create(email: "bob@smith.com")
      
      c2 = RHapi::Contact.find_by_email("bob@smith.com")
      
      expect(c2.properties.email).to eq("bob@smith.com")
    end
  end
  
  describe "recent" do
    it "should return recent contacts", :vcr do
       result = RHapi::Contact.recent
       expect(result.contacts.length).to be > 0
    end
  end
  
end