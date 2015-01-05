gem install bundler
bundle install
bundle config --delete bin    # Turn off Bundler's stub generator
rake rails:update:bin         # Use the new Rails 4 executables
