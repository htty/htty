module HTTY; end

# Represents a Hash that preserves the insertion order of values. This class
# exists because Hash did not have this behavior in Ruby v1.8.7 and earlier.
class HTTY::OrderedHash

  def initialize(hash={})
    @inner_hash = {}
    @inner_keys = {}
    @ordered_keys = []
    hash.each_pair do |key, value|
      self[key] = value
    end
  end

  def [](key)
    @inner_hash[key.downcase]
  end

  def []=(key, value)
    @ordered_keys << key.downcase unless @inner_hash.key?(key.downcase)
    @inner_keys[key.downcase] = key
    @inner_hash[key.downcase] = value
    self
  end

  def ==(other_hash)
    if other_hash.kind_of?(self.class)
      return (other_hash.instance_variable_get('@inner_hash') == @inner_hash) &&
             (other_hash.instance_variable_get('@inner_keys') == @inner_keys)
    end
    if other_hash.kind_of?(@inner_hash.class)
      return other_hash.keys.all? do |k|
        other_hash[k] == @inner_hash[k]
      end
    end
    false
  end

  def clear
    @inner_hash.clear
    @inner_keys.clear
    @ordered_keys.clear
  end

  def delete(key)
    @ordered_keys.delete(key.downcase) if @inner_hash.key?(key.downcase)
    @inner_keys.delete(key.downcase)
    @inner_hash.delete(key.downcase)
  end

  def empty?
    @inner_hash.empty?
  end

  def to_a
    @ordered_keys.inject([]) do |result, normalized_key|
      result + [[@inner_keys[normalized_key], @inner_hash[normalized_key]]]
    end
  end

end
