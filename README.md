# Upland Mobile Commons Ruby Gem
[![Build Status](https://travis-ci.org/controlshift/upland_mobile_commons_rest.svg?branch=master)](https://travis-ci.org/controlshift/upland_mobile_commons_rest)

A ruby gem for interacting with the Upland Mobile Commons API. 

## Usage

```ruby
client = UplandMobileCommonsRest.new(username: 'user', password: 'password')
client.campaigns.list
```

