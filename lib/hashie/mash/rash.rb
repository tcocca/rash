require 'hashie/mash'

module Hashie
  class Mash
    class Rash < Mash

      protected

      def convert_key(key) #:nodoc:
        underscore_string(key.to_s)
      end

      # Unlike its parent Mash, a Rash will convert other Hashie::Hash values to a Rash when assigning
      # instead of respecting the existing subclass
      def convert_value(val, duping=false) #:nodoc:
        case val
        when self.class
          val.dup
        when ::Hash
          val = val.dup if duping
          self.class.new(val)
        when ::Array
          val.collect{ |e| convert_value(e) }
        else
          val
        end
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
          squeeze("_").
          downcase
      end

    end
  end
end
