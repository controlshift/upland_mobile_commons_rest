# Upland Mobile Commons Ruby Gem
[![CI Status](https://github.com/controlshift/upland_mobile_commons_rest/actions/workflows/ci.yml/badge.svg)](https://github.com/controlshift/upland_mobile_commons_rest/actions/workflows/ci.yml)

A ruby gem for interacting with the Upland Mobile Commons API.

## Usage

```ruby
client = UplandMobileCommonsRest.new(api_key: 'api-key')
# List Campaigns
client.campaigns.list

# create a group
client.groups.create('Chocolate Lovers')

# create/update a profile
client.profiles.update(phone_number: '123-456-7890')

# retrieve a profile by its phone number
client.profiles.get('123-456-7890')
```

