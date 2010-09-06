# Defines HTTY::CookiesUtil.

module HTTY; end

# Provides support for marshaling HTTP cookies to and from strings.
module HTTY::CookiesUtil

  # Returns the specified _cookies_string_ HTTP header value deserialized to an
  # array of cookies.
  def self.cookies_from_string(cookies_string)
    return [] unless cookies_string
    cookies_string.split(COOKIES_DELIMITER).collect do |name_value_string|
      name_and_value = name_value_string.split(COOKIE_NAME_VALUE_DELIMITER, 2)
      name_and_value << nil if (name_and_value.length < 2)
      name_and_value
    end
  end

  # Returns the specified array of _cookies_ serialized to an HTTP header value.
  # Returns +nil+ if _cookies_ is +nil+ or empty or if it contains only +nil+
  # cookie values.
  def self.cookies_to_string(cookies)
    cookies = Array(cookies)
    return nil if cookies.empty?

    cookies.collect do |name, value|
      [name, value].compact.join COOKIE_NAME_VALUE_DELIMITER
    end.join COOKIES_DELIMITER
  end

protected

  COOKIE_NAME_VALUE_DELIMITER = '='
  COOKIES_DELIMITER           = '; '

end
