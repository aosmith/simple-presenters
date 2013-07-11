module SimplePresenters
    module Presenter

      def default
        all
      end

      def all
        attributes.symbolize_keys.keys - filtered_params
      end

      def present_as format
        @format = format
        attributes = self.send(@format)
        attributes.inject({}) do |object_hash, attribute|
          if self.respond_to? attribute.to_sym
            value = self.public_send(attribute)
            object_hash[attribute.to_s.gsub(/[?|!]/, '').to_sym] = process_value(value)
          end
          object_hash
        end
      end

      private

      def process_value value
        value = if defined?(ActiveRecord) and value.is_a? ActiveRecord::Base
          if value.respond_to? @format.to_sym and value.respond_to? :present_as
            value.present_as @format.to_sym
          elsif value.respond_to? :default and value.respond_to? :present_as
            value.present_as :default
          else
            value.class.send(:include, SimplePresenters::Presenter)
            value.present_as :default
          end
        else
          value
        end
      end

      def filtered_params
        params = []
#        if defined?(Rails)
#          params += Rails.application.config.filter_parameters
#        end
        if self.class.respond_to? :filtered_parameters
          params += self.class.filtered_parameters
        end
        params
      end

    end
end
