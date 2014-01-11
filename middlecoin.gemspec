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

base = __FILE__
$:.unshift(File.join(File.dirname(base), 'lib'))

require 'middlecoin'

Gem::Specification.new do |s|
	s.name = "#{Middlecoin::APP_NAME}"
	s.version = Middlecoin::VERSION
	s.homepage = "http://www.github.com/hammackj/middlecoin"
	s.summary = "#{Middlecoin::APP_NAME}"
	s.description = "#{Middlecoin::APP_NAME} is a parser/status checker for middlecoin.com"
	s.license = "MIT"

	s.author = "Jacob Hammack"
	s.email = "jacob.hammack@hammackj.com"

	s.files	= Dir['[A-Z]*'] + Dir['lib/**/*'] + ['middlecoin.gemspec']
	s.bindir = "bin"
	s.executables = "#{Middlecoin::APP_NAME}"
	s.require_paths = ["lib"]
	s.has_rdoc = 'yard'
	s.extra_rdoc_files = ["README.markdown", "LICENSE"]

	s.required_rubygems_version = ">= 1.8.24"
end
