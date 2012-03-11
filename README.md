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

## Setting up a Sirportly Client

All requests to API are made through a `Sirportly::Client` instance which must be initialised
using your API token & secret as shown below. Once this has been initialised, you can use it
to access your database.

```ruby
sirportly = Sirportly::Client.new('the_token', 'the_secret')
```

If you have been provided with an application token to use with user-based authentication you 
can set this as follows:

```ruby
Sirportly.application = 'your_application_token'
```

## Accessing Static Data Objects

The Sirportly API provides access to all the data objects stored in your Sirportly database.
At the current time, these cannot be edited through the API. 

```ruby
sirportly.statuses                  #=> Set of all statuses as Sirportly::Status objects
sirportly.priorities.first          #=> A Sirportly::Priority object for the first record

sirportly.brands.first.departments  #=> Array of Sirportly::Department objects

sirportly.user('adam')              #=> Returns a Sirportly::User object
sirportly.customer('Dave Smith')    #=> Returns a Sirportly::Customer object
```

You can access the following objects using this method: brands, departments, escalation_paths,
filters, priorities, slas, statuses, teams and users.

### Pagination

Some results from the API are paginated as outlined below. By default, it will always 
return the first page.

```ruby
users = sirportly.users(:page => 1)

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

