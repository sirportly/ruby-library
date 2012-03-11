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

## Accessing Tickets

You can access ticket information directly through the Ruby interface.

```ruby
sirportly.tickets                   #=> A set of all tickets (paginated)
sirportly.ticket('AB-123123')       #=> Returns a Sirportly::Ticket object for the passed reference
```

## Manipulating Tickets

In addition to accessing ticket data, you can also manipulate tickets straight through the
`Sirportly::Ticket` instance.

```ruby
ticket = sirportly.ticket('AB-123123')

# Execute a macro on a ticket by passing the name or ID of a macro
ticket.run_macro('Mark as waiting for staff')     #=> true

```

## Posting updates to tickets

Posting updates to tickets is a simple affair and the `post_update` method on a `Sirportly::Ticket`
will accept the same parameters as defined in the [documentation](http://www.sirportly.com/docs/api-specification/tickets/posting-an-update).

As you will see from the examples below, you can pass a `Sirportly::User` instance to `user` and a 
`Sirportly::Customer` instance to `customer` although strings are perfectly acceptable too.

The `post_update` method will return a `Sirportly::TicketUpdate` instance and the new update will
be added to the `updates` array on the original ticket.

```ruby
ticket = sirportly.ticket('AB-123123')

# To post a system message without a user
ticket.post_update(:message => "My Example Message")

# To post an update as the ticket customer
ticket.post_update(:message => "My Example Message", :customer => ticket.customer)

# To post an update as a user
user = sirportly.user('adam')
ticket.post_update(:message => "My Example Message", :user => user)

# To post an update and e-mail it to the customer
ticket.post_update(:message => "My Example", :user => user, :outbound_address => 'support@yourdomain.com')

# To post a private update as a user
ticket.post_update(:message => "Private Msg", :private => true, :user => user)
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

## Pagination

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

