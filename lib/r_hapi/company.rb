require 'rubygems'
require 'active_support'
require 'active_support/inflector/inflections'

module RHapi

  class Company
    include Connection
    extend Connection::ClassMethods
    self.version = "v2"

    attr_accessor :attributes, :changed_attributes # reference changes from nested object
    attr_reader :read_only_members

    def initialize(data=nil)
      unless data.nil?
        @read_only_members = data.slice!('properties') # Construct read-only attributes (e.g.: portal id)
        data['properties'] = Property.new(data['properties'])
        self.attributes = data # Read-writable properties (e.g.: first & last name)
      else
        self.attributes = { 'properties' => Property.new }
        @read_only_members = {}
      end
      self.changed_attributes = {}
    end

    # Class methods ----------------------------------------------------------

    def self.create(params)
      company = Company.new
      company.update_attributes(params)
      # returns new company object # TODO: ensure returns company object
    end

    # TODO: implement reload

    # # Finds companies and returns an array of companies.
    # # An optional string value that is used to search several basic company fields: first name, last name, email address,
    # # and company name. According to HubSpot docs, a more advanced search is coming in the future.
    # # The default value for is nil, meaning return all company.
    # def self.find(search=nil, options={})
    #   options[:q] = search unless search.nil?
    #   response = get(url_for({
    #     :api => 'companies',
    #     :resource => 'search',
    #     :method => 'query'
    #   }, options))
    #
    #   company_data = JSON.parse(response.body_str)
    #   CompanySearch.new(company_data)
    # end

    # Finds specified company by its unique id (vid).
    def self.find_by_company_id(company_id)
      response = get(url_for(
        :api => 'companies',
        :resource => 'companies',
        :filter => company_id
      ))

      company_data = JSON.parse(response.body_str)
      Company.new(company_data)
    end

    # # Finds specified company by its email address.
    # def self.all_by_domain(domain)
    #   response = get(url_for(
    #     :api => 'companies',
    #     :resource => 'companies',
    #     :filter => 'domain',
    #     :identifier => domain
    #   ))
    #
    #   company_data = JSON.parse(response.body_str)
    #   CompanyAll.new(company_data)
    # end
    #
    # # Finds all companies
    # def self.all(options={})
    #   response = get(url_for({
    #     :api => 'companies',
    #     :resource => 'lists',
    #     :filter => 'all',
    #     :member => 'companies',
    #     :context => 'all'
    #   }, options))
    #
    #   company_data = JSON.parse(response.body_str)
    #   CompanyAll.new(company_data)
    # end
    #
    # # Finds most companies
    # def self.recent(options={})
    #   response = get(url_for({
    #     :api => 'companies',
    #     :resource => 'lists',
    #     :filter => 'recently_updated',
    #     :member => 'companies',
    #     :context => 'recent'
    #   }, options))
    #
    #   company_data = JSON.parse(response.body_str)
    #   CompanyRecent.new(company_data)
    # end
    #
    # # Gets portal statistics.
    # def self.statistics
    #   response = get(url_for(
    #     :api => 'companies',
    #     :resource => 'companies',
    #     :method => 'statistics'
    #   ))
    #   statistics_data = JSON.parse(response.body_str)
    #   PortalStatistic.new(statistics_data)
    # end
    #
    # class << self
    #   alias_method :search, :find
    #   alias_method :find_all, :all
    #   alias_method :newest, :recent
    #   alias_method :most_recent, :recent
    # end

    # Instance methods -------------------------------------------------------
    def save
      params = []
      self.properties.changed_attributes.each_pair do |key, value|
        params << { :name => key, :value => value }
      end
      params = { 'properties' => params }
      # call create or update API method accordingly
      if self.read_only_members.empty?
        unless self.properties.attributes.include?("name")
          raise(RHapi::AttributeError, "Newly created companies must include a name.")
        end
        response = create_new(params)
      else
        response = update_existing(params)
      end
      self.properties.changed_attributes = {}
      response
    end
    
    def update(params={})
      unless params.empty?
        update_attributes(params) # changes values and sets changed_attributes for Property object
        # at self.properties[.{changed_}attributes], then runs save
      else
        save
      end
    end

    # Note: Takes the exact string name of the property to be changed
    # TODO: only allow existing properties
    def update_attribute(name, value) # to be deprecated in rails 4 by update_column
      self.properties.send(name.to_s + '=', value)
      save
    end

    # Note: Takes the exact string name of the property to be changed
    # TODO: only allow existing properties
    def update_attributes(params)
      raise(RHapi::AttributeError, "The params must be a hash.") unless params.is_a?(Hash)
      params.each do |name, value|
        self.properties.send(name.to_s + '=', value)
      end
      save # only call API once rather than repeatedly saving with update_attribute calls
    end

    def create_new(params)
      response = post(Company.url_for(
        :api => 'companies',
        :resource => 'companies'
      ), params)
      company_data = JSON.parse(response.body_str)
      Company.new(company_data)
    end

    def update_existing(params)
      response = post(Company.url_for(
        :api => 'companies',
        :resource => 'company',
        :filter => 'vid',
        :identifier => self.vid,
        :method => 'profile'
      ), params)
      true
    end

    def delete
      response = http_delete(Company.url_for(
        :api => 'companies',
        :resource => 'company',
        :filter => 'vid',
        :identifier => self.vid
      ))
      true
    end

    alias_method :destroy, :delete

    # Work with data in the data hash
    def method_missing(method, *args, &block)
      attribute = ActiveSupport::Inflector.camelize(method.to_s, false)

      if attribute =~ /=$/ # Handle assignments only for read-writable attributes
        attribute = attribute.chop
        return super unless self.attributes.include?(attribute)
        self.changed_attributes[attribute] = args[0]
        self.attributes[attribute] = args[0]
      elsif self.attributes.include?(attribute) # Accessor for existing attributes
        self.attributes[attribute]
      elsif self.read_only_members.include?(attribute) # Accessor for existing read-only members
        self.read_only_members[attribute]
      else # Not found - use default behavior
        super
      end

    end

    # Private methods
    private :create_new
    private :update_existing
 
  end
  
end
