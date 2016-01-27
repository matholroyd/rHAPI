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
  
  describe "group_create", :vcr do
    it "should import 1 contact" do
      email = new_email
      
      RHapi::Contact.group_create([
        email: email,
        phone: "1234567890"
      ])

      c2 = RHapi::Contact.find_by_email(email)

      expect(c2.properties.phone).to eq("1234567890")
    end
  end
  
  describe "recent" do
    it "should return recent contacts", :vcr do
       result = RHapi::Contact.recent
       expect(result.contacts.length).to be > 0
    end
  end
  
  def new_email
    data = RHapi::Contact.recent
    digest = Digest.hexencode(data.to_s)[0, 20]
    
    "#{digest}@example.com"
  end
  
end