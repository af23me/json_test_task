# Test Task for Parsing JSON files and write new data to output file

## Intro

Note: *This repo was created as test task and do not used in production.*

Test task requirements was:

You have a json file of users.
You have a json file of companies.

Please look at these files.
Create code in Ruby that process these files and creates an
output.txt file.

Criteria for the output file.
Any user that belongs to a company in the companies file and is active
needs to get a token top up of the specified amount in the companies top up
field.

If the users company email status is true indicate in the output that the
user was sent an email ( don't actually send any emails).
However, if the user has an email status of false, don't send the email
regardless of the company's email status.

Companies should be ordered by company id.
Users should be ordered alphabetically by last name.

Important points
- There could be bad data
- The code should be runnable in a command line
- Code needs to be written in Ruby
- Code needs to be cloneable from github
- Code file should be named challenge.rb

An example_output.txt file is included.
Use the example file provided to see what the output should look like.

Assessment Criteria
- Functionality
- Error Handling
- Reusability
- Style
- Adherence to convention
- Documentation
- Communication

## Setup

* Build image: `docker compose build`

## Development

Lets imagine that we have multiple exports which should be imported and as a result of import will be file output.txt

Files for import are located in `tmp/development`. Files which should be processed (users.json, companies.json) will be located in `exports` folder. Output file will be located in folder `imports`. Structure of file name will include provided via command line timestamp.

Run service `docker compose run app /bin/sh`
Run script `ruby challenge.rb timestamp_123`

## Testing

Run tests: `$ docker compose run app rspec spec`

## What was done out of task?

* Setup different environments for script for fast testing
* Added possibility to process specific files (users, companies) from different timestamps

## What can be improved?

* Measure and minimize memory usage while transforming JSON data for large files
* Validate JSON by schema
* Improve object caching and reusing
* Add rubocop linter
* Move templates to files or database
