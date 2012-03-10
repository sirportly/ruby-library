# Sirportly Ruby API

This library allows you to interact with your Sirportly data using a simple to use
Ruby interface.

**This library is still under development and will change considerably over the next
few releases as new functionality is added.**

## Installation

To install the library, you just need to install the Gem.

```
[sudo] gem install sirportly
```

If you have a Gemfile, you can just include `sirportly` in this and run `bundle install`.

## Configuration

In order authenticate to the API, you need to set your API token & secret as shown below:

```ruby
Sirportly.token = '5c7f4c54-b701-aefa-bd50-fef3fbdb7e3e'
Sirportly.secret = 'bdln94x17xivhqvv5s93vv92ei2fun0i2uxusf4834dk5850ve'
```

