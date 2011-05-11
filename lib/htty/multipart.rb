module HTTY; end

class HTTY::CLI; end

# Encapsulates the HTTP multipart logic
module HTTY::Multipart
  extend self

  BOUNDARY = "httyboundary12345"

  def multipart?(request)
    request.respond_to?(:multipart)
  end

  def multipart_set!(request)
    class << request
      attr_accessor :multipart
      
      def body_update
        body_set multipart.map{|k,v| "--#{BOUNDARY}\r\n#{v.to_multipart}"}.join("") + 
        (multipart.length > 0 ? "--#{BOUNDARY}--\r\n" : "")
      end
    end
    request.multipart = Hash.new
    request.header_set("Content-Type","multipart/form-data; boundary=#{BOUNDARY}")
  end

  def multipart_unset!(request)
    class << request 
      undef :multipart
      undef :body_update
    end
    request.header_unset "Content-Type"
    request.body_unset
  end
  
  class StringPart

    def initialize(name, value)
      @name = name
      @value = value
    end 

    def to_multipart
      @m ||= "Content-Disposition: form-data; name=\"#{@name}\";\r\n\r\n#{@value}\r\n"
    end

  end

  class FilePart
    
    def initialize(name, file)
      @name = name
      @f = File.open(file,'rb')
    end 

    def to_multipart
     mime_type = MIME::Types.type_for(@f.path)[0] || MIME::Types["application/octet-stream"][0]
     @m ||= "Content-Disposition: form-data; name=\"#{@name}\"; filename=\"#{File.basename(@f.path)}\"\r\nContent-Type: #{mime_type}\r\n\r\n#{@f.read}\r\n"
    end

  end



end
