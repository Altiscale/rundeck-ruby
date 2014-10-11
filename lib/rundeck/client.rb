module Rundeck
  # Wrapper for the Rundeck REST API.
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include Execution
    include Jobs
    include Keys

    def objectify(result)
      if result.is_a?(Hash)
        ObjectifiedHash.new(result)
      elsif result.is_a? Array
        result.map! { |e| ObjectifiedHash.new(e) }
      elsif result.nil?
        nil
      else
        fail Error::Parsing, "Couldn't parse a response body"
      end
    end
  end
end
