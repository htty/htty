require 'net/http'

module Net

  class HTTP < Protocol

    # Represents a HTTP PATCH request. This class exists because Net::HTTP did
    # not have this behavior in Ruby v1.9.2 and earlier.
    class Patch < HTTPRequest

      METHOD            = 'PATCH'
      REQUEST_HAS_BODY  = true
      RESPONSE_HAS_BODY = true

    end

    def patch(path, data, initheader, &block)
      res = nil
      request(Patch.new(path, initheader), data) do |r|
        r.read_body(nil, &block)
        res = r
      end
      unless @newimpl
        res.value
        return res, res.body
      end
      res
    end

  end

end
