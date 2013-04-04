# Chronicles application

This application is designed to keep track of, and allow online gaming with
your characters for [Chronicles](http://ballerup-chronicles.herokuapp.com).

This readme concerns setting up the environment, to you can help develop this
application.

## Setup and requirements

It's required that you have a few things installed, before you can run this
application locally.

1. You need to have [ruby 2.0.0-p0](http://www.ruby-lang.org/en/downloads) or later installed.
2. You need to have [mongodb](http://www.mongodb.org) running on your machine.
3. You need to have [git](http://git-scm.com) installed.
4. Clone the repository by running `git clone git@github.com:ekampp/chronicles.git chronicles`
5. You need to copy a few files:
  * Copy `.env.example` to `.env`
  * Copy `config/mongod.conf.example` to `config/mogod.conf`
6. Open your terminal and run `foreman start`

You should now be able to view the application on `localhost:5000`.

If you are on a mac, you can use [homebrew](http://mxcl.github.com/homebrew)
to install most of the binaries and [rbenv](https://github.com/sstephenson/rbenv)
for managing the ruby versions.

## Testing

The application is build from the TDD pholosofy, so before you implement
anything, you should write the test, and make sure it fails (because you
haven't implemented the feature yet). The implement the feature, and make sure
the test passes.

You can start a continuos testing server on your local machine using
[guard](https://github.com/guard/guard).

The tests should be written using [rspec](https://github.com/rspec/rspec) and
[capybara](https://github.com/jnicklas/capybara).

## Questions

If you have ant questions, you can mail me at emil@kampp.me
