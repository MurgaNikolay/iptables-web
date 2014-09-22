module Mixin
  module Country
    def country(ip)
      @country ||= {}
      return @country[ip] if @country[ip]
      country = MultiJson.load(::RestClient.get("https://restapi.tunehog.com/api/geoip.json?ip=#{ip}").body, symbolize_keys: true)
      if country[:country_code]
        @country[ip] = country[:country_code]
        return @country[ip]
      end
      ''
    end
  end
end
