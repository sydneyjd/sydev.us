# sydev.us
The source files for my website hosted at https://www.sydev.us

To install deps run:
~~~~~~~~~~~~~~~~
# apt install ruby-bundler
$ bundle install --path .gems
~~~~~~~~~~~~~~~~

The `--path` option to `bundler` ensures that the gems are kept
logically separate from any system gems.

Then use `nanoc` to compile and serve the site:

~~~~~~~~~~~~~~~~
$ bundle exec nanoc compile
$ bundle exec nanoc view
~~~~~~~~~~~~~~~~

Site is available at http://localhost:3000/
