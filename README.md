# README

## Run it

Running the following will seed data and start the server.

`./bin/setup && foreman start`

There is a rake task that can bee ran to re-import the seed data: `rails import_data:run`

### Architecture

There are 3 main components: Web server, Postgres instance, and redis.  

Redis is used for storing background jobs (we're not using cache, so this is its only purpose)

When `foreman` is run, it will start the web server and it will start the sidekiq server.  
Using sidekiq-cron, we are able to have a job that runs every 30 minutes to re-populate the data.

Due to sidekiq, the project requires redis.  If redis does not exist on your system, the project will still 
run via `./bin/setup && ./bin/rails s`

> Database

The project uses postgreSQL for the datastore and `pre_codes` is serialized with an array column.

### Performance / Scalability

* Database connection splitting for reads and writes
  * Currently both set to the same db
* API-only app config
  * Gets rid of unneeded middleware.  I also removed mail, storage, and view modules we don't need. 

> There are a bunch of other ways to go about this but this makes sense as not to bloat the project.  [Horizontal Sharding](https://github.com/rails/rails/pull/38531) is interesting but sharding can be too much work, given that this app will be read heavy and scalable through replicas.

## Set it up

First, install 'em with [Homebrew](https://brew.sh):

```bash
brew install postgres redis
```

Then set them up to automatically start and 
[run in the background](https://thoughtbot.com/blog/starting-and-stopping-background-services-with-homebrew) 
every time you turn on your computer:

```bash
brew services start postgres
brew services start redis
```

> This is optional:
>
> * Then create a user for the Postgres database.
> * The password for the user is just "password" (without the quotes). You want to answer **yes** to making 
it a superuser.
> ```bash
> createuser --interactive --pwprompt tapout
> ```

### 2. Install Ruby dependencies

tapout-api depends on a specific version of Ruby.  The best way to do this is to use `rvm` (Ruby Version Manager).

To install `rvm`, first make sure you have `gpg`:

```bash
brew install gpg
```

Then, from a new terminal tab, follow the instructions on [rvm.io](https://rvm.io/rvm/install) to finish installing 
the latest stable release of the `rvm` command-line tool.

Check the version of Ruby that tapout-api relies on (`cat .ruby-version`), then open another new terminal tab and install 
that particular version of Ruby using RVM.  For example:

```bash
rvm install `cat .ruby-version`
```

Now open a new terminal tab one more time, and `cd` out and then back into your local `tapout-api` 
directory one more time to trigger the creation of a gemset.

Next, reinstall the `bundler` gem:

```bash
gem install bundler
```

And last but not least, install tapout-api's local Ruby dependencies:

```bash
bundle install
```
