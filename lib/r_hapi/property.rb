module RHapi
  class Property
    include Connection
    extend Connection::ClassMethods
  
    attr_accessor :attributes, :changed_attributes
  
    def initialize(data=nil)
      unless data.nil?
        data.each do |property, hash|
          data[property] = hash["value"]
        end
    
        self.attributes = data
      else
        self.attributes = {}
      end
      self.changed_attributes = {}
    end

    # Instance methods -------------------------------------------------------
    # Work with data in the data hash
    def method_missing(method, *args, &block)
      attribute = method.to_s

      if attribute =~ /=$/ # Define property -- does not have to exist
        attribute = attribute.chop
        self.changed_attributes[attribute] = args[0]
        self.attributes[attribute] = args[0]
      else
        return super unless self.attributes.include?(attribute)
        self.attributes[attribute]
      end 
          
    end

  end
end