require 'uri'

module NewRelicHttpProxy

  def proxy_url(args={})
    return '' if args.empty?

    u = URI::HTTP.build :scheme   => args['scheme'],
                        :host     => args['host'],
                        :port     => args['port'].to_i

    if args['user'] && args['password']
      u.userinfo = "#{args['user']}:#{args['password']}"
    end

    u.to_s.tap do |url|
      url << ":#{args['port']}" if args['port'] == '80'
    end
  end

end

class Chef::Recipe
  include NewRelicHttpProxy
end
