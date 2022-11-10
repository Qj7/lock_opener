# get code
git clone http://github.com/qj7/lock_opener.git
cd lock_opener
bin/setup

# use
cd lock_opener
uncomment last line in lib/lock.rb
set needed values
ruby lib/lock.rb

# check implementation
bin/rspec lib/lock.rb