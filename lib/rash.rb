require 'rubygems'
require 'hashie'

module Hashie
  class Rash < Mash
    
    protected
    
    def convert_key(key) #:nodoc:
      underscore_string(key.to_s)
    end
    
    # converts a camel_cased string to a underscore string
    # subs spaces with underscores, strips whitespace
    # Same way ActiveSupport does string.underscore
    def underscore_string(str)
      str.to_s.strip.
        gsub(' ', '_').
        gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end
    
    def convert_value(val, duping=false) #:nodoc:
      obj = super
      obj = self.class.new(obj) if Hashie::Mash === obj
      obj
    end
    
    def initializing_reader(key)
      ck = convert_key(key)
      regular_writer(ck, self.class.new) unless key?(ck)
      regular_reader(ck)
    end
    
  end
  
end
