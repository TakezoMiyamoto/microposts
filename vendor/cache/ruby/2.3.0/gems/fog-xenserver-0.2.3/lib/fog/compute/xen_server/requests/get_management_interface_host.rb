module Fog
  module Compute
    class XenServer
      class Real
        def get_management_interface_host(ref)
          @connection.request({ :parser => Fog::Parsers::XenServer::Base.new, :method => "host.get_management_interface" }, ref)
        end
      end
    end
  end
end
