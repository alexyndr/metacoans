# frozen_string_literal: true

def attribute(name, &block)
  name, value = name.first if name.is_a?(Hash)
  create_attribute(name, value, &block)
end

def create_attribute(name, value = nil, &block)
  define_method(name.to_s) do
    unless instance_variable_defined?(:"@#{name}")
      instance_variable_set(:"@#{name}", block_given? ? instance_eval(&block) : value)
    end
    instance_variable_get(:"@#{name}")
  end

  define_method("#{name}=") do |value|
    instance_variable_set(:"@#{name}", value)
  end

  define_method("#{name}?") do
    !!instance_variable_get(:"@#{name}")
  end
end
