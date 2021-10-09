# README

# Getting started

This project runs with Ruby 2.7.2 and Rails 6.1.4.1

To install Ruby please check https://www.ruby-lang.org/en/documentation/installation/

Then run ```bundle install```

Run ```'rails db:prepare'``` to create and migrate de database

If you want to populate your database with dummy data run ```rails db:seed```
As still there are no validations for models, please avoid run seeds twice.


# API Usage

There is a JSON API-compliant for requesting metrics at the endpoint ```/api/v1/mertics```
Params:
A param group_by is needed to aggregate metrics. Values permitted are "day", "hour", "minute"
To use the endpoint in your local machine, start the server: ```rails s```

Test with curl: in your command line type ```curl --request GET 'http://localhost:3000/api/v1/metrics?group_by=day'``` it should return something similar (depending on your data) to ```{"2021-10-08 00:00":"10.0","2021-10-09 00:00":"10.0"}%```

Test in browser: in your browser go to http://localhost:3000/api/v1/metrics?group_by=day, it should return the same than testing in command line.

# Tests

To run the test suite type in the command line ```rspec ./spec```. It will return the number of examples and the failures: ```5 examples, 0 failures```

## The challenge

We want a Front-end + Backend application that allows you to post and visualize metrics. Each metric will have a Timestamp, name, and value. The metrics will be shown in a timeline and must show averages per minute/hour/day. The metrics will be persisted in the database.

You can find the Front-end app in https://github.com/edgarbarrero/metrics-frontend
