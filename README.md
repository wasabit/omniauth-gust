# OmniAuth Gust

This gem contains the Gust strategy for OmniAuth.

Gust uses the OAuth2 flow, you can read about it here: http://angel.co/api/oauth/faq

## How To Use It

So let's say you're using Rails, you need to add the strategy to your `Gemfile`:

    gem 'omniauth-gust'

You can pull them in directly from github e.g.:

    gem 'omniauth-gust', :git => 'https://github.com/wasabit/omniauth-gust.git'

Once these are in, you need to add the following to your `config/initializers/omniauth.rb`:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :gust, "consumer_key", "consumer_secret" 
    end

You will obviously have to put in your key and secret, which you get when you register your app with Gust (they call them API Key and Secret Key). 

Now just follow the README at: https://github.com/intridea/omniauth

## License

Copyright (c) 2012 by Sebastian Rabuini

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.