# frozen_string_literal: true

# BEGIN
# module for work with Models

module Model
  def self.included(base)
    base.extend(ClassMethods)
  end

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end

  def attributes
    instance_variables.each_with_object({}) do |var, hash|
      name = var.to_s.delete('@')
      hash[name.to_sym] = send(name) if respond_to?(name)
    end
  end

  module ClassMethods
    def attribute(name, options = {})
      define_method(name) do
        value = instance_variable_get("@#{name}")
        value = convert_value(value, options[:type]) if options[:type] && value
        value
      end

      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
    end
  end

  private

  def convert_value(value, type)
    case type
    when :string
      value.to_s
    when :integer
      value.to_i
    when :boolean
      !!value
    when :datetime
      value.is_a?(DateTime) ? value : DateTime.parse(value.to_s)
    else
      value
    end
  end
end
# END
