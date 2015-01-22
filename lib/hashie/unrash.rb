require 'hashie/mash'

module Hashie
  class Unrash < Mash

    protected

    def convert_key(key) #:nodoc:
      camel_case_lower(key.to_s)
    end

    # Unlike its parent Mash, a Unrash will convert other Hashie::Hash values to a Unrash when assigning
    # instead of respecting the existing subclass
    def convert_value(val, duping=false) #:nodoc:
      case val
        when self.class
          val.dup
        when ::Hash
          val = val.dup if duping
          self.class.new(val)
        when Array
          val.collect{ |e| convert_value(e) }
        else
          val
      end
    end

    # converts a underscore string to a lowerCamelCase string
    def camel_case_lower(str)
      str.strip().gsub(' ','').split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
    end

    def camel_case(str)
      return str if str !~ /_/ && str =~ /[A-Z]+.*/
      str.strip().gsub(' ','').split('_').map{|e| e.capitalize}.join
    end

  end

end