# Odin Project - Kittens API

This is a project to set up a Rails app to be a data-producing API.

Link to project description: http://www.theodinproject.com/courses/ruby-on-rails/lessons/apis?ref=lnav

On that page, go to "Project 1: Building a Simple Kittens API".

## Getting Started / Installation

1. Clone this repository and cd into it
2. `bundle` to install gem dependencies
3. Run the tests `rails test` - if all is green, you are good to go!
4. You can seed the database with 10 initial "kittens" by running `rails db:migrate:reset` then `rails db:seed`
5. Run the rails server with `rails server` - you can now view the html version of the site at `localhost:3000`.
6. CRUD operation are performed via all the regular RESTful routes - eg adding a new kitten is at `/kittens/new`

## Accessing the API

The API is accessible on the index and show routes - ie serving a list of all kittens, and serving details of a particular kitten

You have a few options for accessing the API:

### RestClient in IRB/Pry

https://github.com/rest-client/rest-client

Copied from The Odin Project:

1. In IRB or Pry `require 'rest_client'` (you may need to `gem install rest_client` if you haven't already). [I had to shut down the server then restart it before this worked.]
2. Test it is working by making a request to your application using  `response = RestClient.get("http://localhost:3000/kittens")` - the `response` object should be a string of html. If you check out your server output, it's probably processing as XML, e.g. "Processing by KittensController#index as XML"
3. To get a JSON response, add the option :accept => :json, e.g. `RestClient.get("http://localhost:3000/kittens/1", :accept => :json)`. This now returns a string in JSON format.
4. To view the object in proper JSON format, use `JSON.parse(response)`. This returns:
```
=> {"id"=>1,
 "name"=>"Bobbles The Kitten",
 "age"=>1,
 "cuteness"=>1,
 "softness"=>1,
 "created_at"=>"2016-12-30T23:28:35.983Z",
 "updated_at"=>"2016-12-30T23:28:35.983Z"}
 ```

### Javascript

1. Open up a tab for `localhost:3000`
2. In the console, you can use ajax to request JSON:
```
var data = $.ajax({
  url: "http://localhost:3000/kittens",
  type: "GET",
  dataType: "json",
});
```
3. The data object has an attribute called responseJSON which contains the JSON response from the server.

### To Do and further developments

1. I would like to work out how to do full CRUD operations using an API, without exposing to risk of cross site forgery attacks

### Authors

B-raw + Odin Project
