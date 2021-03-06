# The MIT License (MIT)

# Copyright (c) 2014 Jacob Hammack

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "middlecoin"
require 'rake'
require 'rake/testtask'

task :build do
	system "gem build #{Middlecoin::APP_NAME}.gemspec"
end

task :tag_and_bag do
	system "git tag -a v#{Middlecoin::VERSION} -m 'version #{Middlecoin::VERSION}'"
	system "git push --tags"
	system "git checkout master"
	#system "git merge #{Middlecoin::VERSION}"
	system "git push"
end

task :release => [:tag_and_bag, :build] do
 	system "gem push #{Middlecoin::APP_NAME}-#{Middlecoin::VERSION}.gem"
	puts "Just released #{Middlecoin::APP_NAME} v#{Middlecoin::VERSION}. #{Middlecoin::APP_NAME} is a status checker for middlecoin.com. More information at http://github.com/hammackj/middlecoin"
	system "rm #{Middlecoin::APP_NAME}-#{Middlecoin::VERSION}.gem"
end

task :clean do
	system "rm *.gem"
	system "rm *.db"
	system "rm *.cfg"
	system "rm *.pdf"
	system "rm -rf coverage"
end

task :test do
	t.libs << "test"
	t.pattern = 'test/*/*_test.rb'
	t.verbose = true
end

task :merge do
	system "git checkout master"
	system "git merge #{Risu::VERSION}"
	system "git push"
end
