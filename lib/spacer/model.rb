## Graciously stolen from Facebooker
#
# Copyright (c) 2007 Chad Fowler <chad@infoether.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in the
# Software without restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
# Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
# AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Spacer
  ##
  # helper methods primarily supporting the management of Ruby objects which are populatable via Hashes.  
  # Since most Facebook API calls accept and return hashes of data (as XML), the Model module allows us to
  # directly populate a model's attributes given a Hash with matching key names.
  module Model
    class UnboundSessionException < Exception; end
    def self.included(includer)
      includer.extend ClassMethods
    end
    module ClassMethods
      ##
      # Instantiate a new instance of the class into which we are included and populate that instance's
      # attributes given the provided Hash.  Key names in the Hash should map to attribute names on the model.
      def from_hash(hash)
        instance = new(hash)
        yield instance if block_given?
        instance
      end
      
      ##
      # Create a standard attr_writer and a populating_attr_reader      
      def populating_attr_accessor(*symbols)
        attr_writer *symbols
        populating_attr_reader *symbols
      end

      ## 
      # Create a reader that will attempt to populate the model if it has not already been populated
      def populating_attr_reader(*symbols)
        symbols.each do |symbol|
          define_method(symbol) do
            populate unless populated?
            instance_variable_get("@#{symbol}")
          end
        end
      end
      
      def populating_hash_settable_accessor(symbol, klass)
        populating_attr_reader symbol
        hash_settable_writer(symbol, klass)
      end
        
      def populating_hash_settable_list_accessor(symbol, klass)
        populating_attr_reader symbol
        hash_settable_list_writer(symbol, klass)
      end
      
      #
      # Declares an attribute named ::symbol:: which can be set with either an instance of ::klass::
      # or a Hash which will be used to populate a new instance of ::klass::.
      def hash_settable_accessor(symbol, klass)
        attr_reader symbol
        hash_settable_writer(symbol, klass)
      end
      
      def hash_settable_writer(symbol, klass)
        define_method("#{symbol}=") do |value|
          instance_variable_set("@#{symbol}", value.kind_of?(Hash) ? klass.from_hash(value) : value)
        end        
      end
      
      #
      # Declares an attribute named ::symbol:: which can be set with either a list of instances of ::klass::
      # or a list of Hashes which will be used to populate a new instance of ::klass::.      
      def hash_settable_list_accessor(symbol, klass)
        attr_reader symbol
        hash_settable_list_writer(symbol, klass)
      end
      
      def hash_settable_list_writer(symbol, klass)
        define_method("#{symbol}=") do |list|
          instance_variable_set("@#{symbol}", list.map do |item|
            item.kind_of?(Hash) ? klass.from_hash(item) : item
          end)
        end
      end      
    end
    
    def initialize(hash = {})
      populate_from_hash!(hash)
    end

    def populate
      raise NotImplementedError, "#{self.class} included me and should have overriden me"
    end

    def populated?
      !@populated.nil?
    end
    
    ##
    # Set model's attributes via Hash.  Keys should map directly to the model's attribute names.
    def populate_from_hash!(hash)
      unless hash.empty?
        hash.each do |key, value|
          self.__send__("#{key}=", value)
        end
        @populated = true
      end      
    end    
  end
end