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

## Accessing Static Data Objects

The Sirportly API provides access to all the data objects stored in your Sirportly database.
At the current time, these cannot be edited through the API. 

```ruby
Sirportly::Status.all               #=> Set of all statuses as Sirportly::Status objects
Sirportly::Priority.first           #=> A Sirportly::Priority object for the first record

Sirportly::Brand.first.departments  #=> Array of Sirportly::Department objects
```

The following objects can be retrieved in this manner:

* Brand
* Department
* EscalationPath
* Filter
* Priority
* SLA
* Status
* Team
* User

### Pagination

Some results from the API are paginated as outlined below. By default, it will always 
return the first page.

```ruby
users = Sirportly::User.all(:page => 1)

users.each do |user|
  user.is_a?(Sirportly::User)     #=> true
  user.full_name                  #=> "Adam Cooke"
  user.teams                      #=> Array of Sirportly::Team objects
  user.teams.first.name           #=> "First Line Support"
end

users.page              #=> 1
users.total_records     #=> 35
users.pages             #=> 2
users.offset            #=> 0
```

If a result set is not paginated, the methods outlined above will be nil. Pagination will only occur 
at the top level of results and does not happen on arrays within objects.

