require 'rspec/rails/example/rails_example_group'
 
EXAMPLE_GROUPS = {
  :controller => :controllers
  :helper     => :helpers
  :mailer     => :mailers
  :model      => :models
  :request    => '(requests|integration)'
  :routing    => :routing
  :view       => :views
}  

EXAMPLE_GROUPS.each { |k, v| require "rspec/rails/example/#{k}_example_group" }

RSpec::configure do |c|
  EXAMPLE_GROUPS.each do |k, v|
    next unless defined? group = Rspec::Rails.const_get("#{k.capitalize}ExampleGroup") 
    c.include group, :type => :controller, :example_group => {
      :file_path => Regexp.compile(%W[spec #{v}].join('[\\\/]'))
    }
  end
end