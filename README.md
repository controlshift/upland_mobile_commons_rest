# Upland Mobile Commons Ruby Gem
[![Build Status](https://travis-ci.org/controlshift/upland_mobile_commons_rest.svg?branch=master)](https://travis-ci.org/controlshift/upland_mobile_commons_rest)

A ruby gem for interacting with the Upland Mobile Commons API.

## Usage

```ruby
client = UplandMobileCommonsRest.new(username: 'user', password: 'password')
# List Campaigns
client.campaigns.list

# create a group
client.groups.create('Chocolate Lovers')

# create/update a profile
client.profiles.update(phone_number: '123-456-7890')

# retrieve a profile by its phone number
client.profiles.get('123-456-7890')
```

