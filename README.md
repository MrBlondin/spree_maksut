# Spree Maksuturva

Add support for Skrill / MoneyBookers Quick checkout as a payment
method.

## Installation

1. Add the following to your Gemfile

<pre>
    gem 'spree_maksut', :git => 'git://github.com/spree/spree_maksut.git'
</pre>

2. Run `bundle install`

## Configuring

1. Add a new Payment Method, using: `BillingIntegration::Maksut::QuickCheckout` as the `Prodivder`

2. Click `Create`, and enter your Store's Maksut Merchant
   ID (also called Customer ID) in the field provide.

3. `Save` and enjoy!


Testing
-------

Be sure to add the rspec-rails gem to your Gemfile and then create a dummy test app for the specs to run against.

    $ bundle exec rake test app
    $ bundle exec rspec spec

Copyright (c) 2013 [name of extension creator], released under the New BSD License
