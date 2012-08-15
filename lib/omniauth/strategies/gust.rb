require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Gust < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'read-write'

      option :name, "gust"

      option :client_options, {
        :site => 'https://alpha.gust.com',
        :authorize_url => '/r/oauth/authorize',
        :token_url => '/r/oauth/token'
      }

      uid { 
        raw_info['id'] 
      }

      info do
        prune!({
          'name' => raw_info["user_name"],
          'email' => raw_info["email"],
          'company_name' => raw_info['company_name'],
          'urls' => {
            'profile' => raw_info['profile_url']
          }
        })
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        return @raw_info if @raw_info
        (access_token.options || {}).merge!({:header_format => 'OAuth %s'})
        @raw_info = access_token.get('/r/oauth/user_details').parsed
      end


      private 
        def prune!(hash)
          hash.delete_if do |_, value| 
            prune!(value) if value.is_a?(Hash)
            value.nil? || (value.respond_to?(:empty?) && value.empty?)
          end
        end

    end
  end
end
