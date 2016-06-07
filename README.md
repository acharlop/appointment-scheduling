# Scheduling API

A restful scheduling api providing Create, Update, Delete, and List routes.

The following is guarenteed:

* Start time is after End time
* Appointments do not overlap
* When creating a new appointment is must be in the future
* Return codes 200 (success), 201 (created), 400 (errors provided)

## Technologies used

Ruby on rails is used since is probably the most straightforward way to get a RESTful web API up and running.

### Gems used

* `american_date` for m/d/year format
* `chronic` for more intuative datetime parsing
* `validates_timeliness` for datetime validation


### Development environment

* Postman - testing
* Sqlite3 - database

### Production envrironment

* Heroku - hosting
* PostreSQL - database

## Installation

The app is available on [heroku](http://scheduling-api.herokuapp.com/appts) see below for more details.

If for some reason you want a local copy:

	$ git clone https://github.com/acharlop/scheduling-api.git
	$ cd scheduling-api
	$ bundle install
	$ rake db:create db:migrate db:seed
	$ rails s

### Options

For more user friendly routes uncomment `, path: "appointments"` in routes.rb file for root url of 
```
http://scheduling-api.herokuapp.com/appointments
```
	
## Usage / Routes

The site is available on [http://scheduling-api.herokuapp.com/appts](http://scheduling-api.herokuapp.com/appts). 

WARNING: It might take a few seconds to wake up if nobody has touched it in a few minutes.

### List

GET [http://scheduling-api.herokuapp.com/appts](http://scheduling-api.herokuapp.com/appts)

#### OPTIONS

For a more detailed list the `start` and `end` parameters can be used

[http://scheduling-api.herokuapp.com/appts?start=11-18-16%2011:15&end=11-19-16](http://scheduling-api.herokuapp.com/appts?start=11-18-16%2011:15&end=11-19-16)

### Create

POST [http://scheduling-api.herokuapp.com/appts](http://scheduling-api.herokuapp.com/appts)

```javascript
{
  "start_time": "m-d-yyyy h:m",
  "end_time": "m/d/yy h:m:s",
  "first_name": "first name",
  "last_name": "last name",
  "comments": "this should WORK"
}
```

A few notes

1. Date and time is very user friendly using the [Chronic gem](https://github.com/mojombo/chronic) and can even handle words such as "tomorrow at 20:00" see the gem documentation for more details
2. All fields are required except for the "comments"
5. Names do not have to be unique
3. If successful the newly created object is returned
4. If unsuccessful list of errors will be returned

### Update

PATCH / PUT [http://scheduling-api.herokuapp.com/appts/ID](http://scheduling-api.herokuapp.com/appts/ID)

ID can be retrived from the index

When updating the same data validation rules apply as with creation

### Delete

DELETE [http://scheduling-api.herokuapp.com/appts/ID](http://scheduling-api.herokuapp.com/appts/ID)

If successful returns the deleted object

## License

Scheduling API is realeased under the [MIT License](http://www.opensource.org/licenses/MIT)
