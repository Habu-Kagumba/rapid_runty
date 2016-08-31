<div style="text-align:center;">
<a href="http://bukly.herokuapp.com"><img src="http://res.cloudinary.com/habu-kagumba/image/upload/v1470398003/rapid_runty_dpkdaq.svg" alt="Rapid Runty" width="200"></a>
</div>


# Rapid Runty

[![Gem Version](https://badge.fury.io/rb/rapid_runty.svg)](https://badge.fury.io/rb/rapid_runty) [![Dependency Status](https://gemnasium.com/badges/github.com/Habu-Kagumba/rapid_runty.svg)](https://gemnasium.com/github.com/Habu-Kagumba/rapid_runty) [![Codeship Status for Habu-Kagumba/rapid_runty](https://codeship.com/projects/c6f3c4d0-3efd-0134-9b91-6a8ca46930c1/status?branch=master) ](https://codeship.com/projects/167383) [![Coverage Status](https://coveralls.io/repos/github/Habu-Kagumba/rapid_runty/badge.svg?branch=master)](https://coveralls.io/github/Habu-Kagumba/rapid_runty?branch=master) [![codebeat badge](https://codebeat.co/badges/e5fef576-c696-4d14-9ca0-2ace5b758642)](https://codebeat.co/projects/github-com-habu-kagumba-rapid_runty) [![Inline docs](http://inch-ci.org/github/Habu-Kagumba/rapid_runty.svg?branch=master&style=flat-square)](http://inch-ci.org/github/Habu-Kagumba/rapid_runty)

**Rapid Runty** is a minimal web framework to get your web project up and running in seconds.

## Dependencies

1. [Ruby](https://github.com/rbenv/rbenv)
2. [SQlite3](https://github.com/sparklemotion/sqlite3-ruby)
3. [Bundler](https://github.com/bundler/bundler)
4. [Rack](https://github.com/rack/rack)
6. [Rspec](https://github.com/rspec/rspec)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rapid_runty'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install rapid_runty
```

## Usage

You application structure should be as follows:

```bash
.
├── Gemfile
├── app
│   ├── controllers
│   ├── models
│   └── views
│       └── layouts
│           └── application.html.haml
├── config
│   ├── application.rb
│   └── routes.rb
├── config.ru
└── db
```

### Hacking

Start by defining an `Application` class that inherits from `RapidRunty::Application`.

```ruby
require 'rapid_runty'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'app', 'controllers')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'app', 'models')

module TodoList
  class TodoApplication < RapidRunty::Application
  end
end
```

#### Configuration

You need to define the `ROOT_DIR` in the `config.ru` file. e.g.

```ruby
require_relative './config/application'
ROOT_DIR = __dir__

use Rack::MethodOverride # masks put and delete methods requests as post requests

run TodoListApplication
```

#### Routes

Define your application routes.

```ruby
TodoApplication.routes.draw do
  root "todo#index"
  get "/todo", to: "todo#index"
  get "/todo/new", to: "todo#new"
  get "/todo/:id", to: "todo#show"
  get "/todo/:id/edit", to: "todo#edit"
  post "/todo", to: "todo#create"
  put "/todo/:id", to: "todo#update"
  delete "/todo/:id", to: "todo#destroy"
end
```

Add the route file to the config file

```ruby
[...]
require_relative './config/routes'
[...]
```

#### Models

Define your models in the `app/models` directory.

```ruby
class Todo < RapidRunty::Model::Base
  to_table :todos
  property :id, type: :integer, primary_key: true
  property :title, type: :text, nullable: false
  property :body, type: :text, nullable: false
  property :created_at, type: :text, nullable: false
  create_table
end
```

#### Controllers

Defines your controllers in the `app/controllers` directory.

```ruby
class TodosController < RapidRunty::BaseController
  def index
    @todos = Todo.all
  end

  def show
    @todo = Todo.find(params['id'])
  end

  def new
  end

  def create
    todo = Todo.new
    todo.title = params['title']
    todo.body = params['body']
    todo.created_at = Time.now.to_s
    todo.save

    redirect_to '/todos'
  end

  def edit
    @todo = Todo.find(params['id'])
  end

  def update
    todo = Todo.find(params['id'])
    todo.title = params['title']
    todo.body = params['body']
    todo.save

    redirect_to "/todos/#{todo.id}"
  end

  def destroy
    todo = Todo.find(params['id'])
    todo.destroy

    redirect_to '/todos'
  end
end
```

#### Views

This are the last piece to make the framework work.

You need to define the layout file located at `app/views/layouts/application.html.haml`.

```haml
!!!
%html{:lang => 'en'}
  %head
    %meta{:content => 'text/html; charset=UTF-8', 'http-equiv' => 'Content-Type'}/
    %meta{:charset => 'UTF-8'}/
    %title Todo Application
  %body
    = yield
```

#### Running the application

To run the application, run from you the root of your application,

```bash
$ rackup
```

## Tests

To run the tests, run this command from the root of your application,

```bash
$ rspec -fd
```

## Limitations

- **TODO** - Generate application files with rake command.
- **TODO** - Support model relationships.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Habu-Kagumba/rapid_runty. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

