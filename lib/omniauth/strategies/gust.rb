require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Gust < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://alpha.gust.com',
        :authorize_url => '/r/oauth/authorize',
        :token_url => '/r/oauth/token'
      }

      def request_phase
        super
      end

      uid { raw_ifno['id'] }

      info do
        {
          "name" => raw_ifno["name"],
          "bio" => raw_ifno["bio"],
          "blog_url" => raw_ifno["blog_url"],
          "online_bio_url" => raw_ifno["online_bio_url"],
          "twitter_url" => raw_ifno["twitter_url"],
          "facebook_url" => raw_ifno["facebook_url"],
          "linkedin_url" => raw_ifno["linkedin_url"],
          "follower_count" => raw_ifno["follower_count"],
          "gust_url" => raw_ifno["gust_url"],
          "image" => raw_ifno["image"],
          "locations" => raw_ifno["locations"],
          "roles" => raw_ifno["roles"]
        }
      end

      def raw_ifno
        access_token.options[:mode] = :query
        @raw_ifno ||= access_token.get('https://api.angel.co/1/me').parsed
      end
    end
  end
end
