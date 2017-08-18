require "active_support/core_ext/object/deep_dup"
require "active_support/core_ext/array/wrap"

class Hash
  # Returns a hash that includes everything except given nested keys.
  #   hash = { a: true, b: { x: true, y: false }, c: nil }
  #   hash.except_nested(:b, :c)            # => { a: true }
  #   hash.except_nested(:a, b: [:x])       # => { b: { y: false }, c: nil }
  #   hash.except_nested(:a, b: [:x, :y])   # => { c: nil }
  #   hash                                  # => { a: true, b: { x: true, y: false }, c: nil }
  #
  # It's useful for limiting a set of parameters to everything but a few known toggles at any depth.
  #   @person.update(params[:person].except_nested(:admin, settings: [:secrect_key]))
  def except_nested(*nested_keys)
    deep_dup.except_nested!(*nested_keys)
  end

  # Removes the given nested keys from hash and returns it.
  #   hash = { a: true, b: { x: true, y: false }, c: nil }
  #   hash.except_nested!(b: [:y])       # => { a: true, b: { x: true }, c: nil }
  #   hash                               # => { a: true, b: { x: true }, c: nil }
  def except_nested!(*nested_keys)
    nested_keys.each do |key|
      if key.is_a?(Hash)
        key.each do |sub_key, sub_value|
          if sub_value.is_a?(Array)
            self[sub_key].delete_if { |k, v| sub_value.include?(k) }
            delete(sub_key) if self[sub_key].empty?
          elsif sub_value.is_a?(Hash)
            self[sub_key].except_nested!(sub_value)
          else
            self[sub_key].except_nested!(Array.wrap(sub_value))
          end
        end
      elsif key.is_a?(Array)
        delete_if { |k, v| k == key.first }
      else
        delete(key)
      end
    end
    self
  end
end
