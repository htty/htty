require 'uri'
require 'base64'

module HTTY; end

# Represents the Headers of a Request or a Response. Headers preserve the
# insertion order and are case insensitive. A custom Hash is used because Hash
# did not have this behavior in Ruby v1.8.7 and earlier.
class HTTY::Headers

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

  def self.basic_authentication_for(username, password = nil)
    ['Authorization',
     'Basic ' + Base64.encode64(
       URI.unescape([username, password].compact.join(':'))
      ).chomp
    ]
  end

  def self.credentials_from(basic_authentication)
    if match = /^Basic (.+)$/.match(basic_authentication)
      credentials = Base64.decode64(match[1]).split(':')
      return yield *credentials if block_given?
      return credentials
    end
  end
end
