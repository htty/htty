require 'uri'
require 'base64'

module HTTY; end

# Behaves like an Hash but preserves the insertion order of values and keys are
# case insensitive
class HTTY::Headers
  def initialize(hash={})
    @inner_hash = {}
    hash.each_pair do |key, value|
      @inner_hash[key] = value
    end
    @inner_keys = []
    @inner_hash.each_key do |k|
      @inner_keys << k
    end
  end

  def [](key)
    @inner_hash[key]
  end

  def []=(key, value)
    @inner_keys << key unless @inner_hash.key?(key)
    @inner_hash[key] = value
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
  end

  def delete(key)
    @inner_keys.delete(key) if @inner_hash.key?(key)
    @inner_hash.delete key
  end

  def empty?
    @inner_hash.empty?
  end

  def to_a
    @inner_keys.inject([]) do |result, key|
      result + [[key, @inner_hash[key]]]
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
