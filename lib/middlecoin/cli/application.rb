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

module Middlecoin
	module CLI

		class Application

			# Initializes a CLI Application
			def initialize
				@options = {}
			end

			# Parses all the command line options
			def parse_options
				begin
					opts = OptionParser.new do |opt|
						opt.banner =	"#{APP_NAME} v#{VERSION}\nJacob Hammack\nhttp://www.hammackj.com\n\n"
						opt.banner << "Usage: #{APP_NAME} [options] <BTC Address>"
						opt.separator ''
						opt.separator 'Other Options'

						opt.on_tail('-v', '--version', "Shows application version information") do
							puts "#{APP_NAME}: #{VERSION}\nRuby Version: #{RUBY_VERSION}\nRubygems Version: #{Gem::VERSION}"
							exit
						end

						opt.on_tail("-?", "--help", "Show this message") do
							puts opt.to_s + "\n"
							exit
						end
					end

					if ARGV.length != 0
						opts.parse!
					else
						puts opts.to_s + "\n"
						exit
					end
				rescue OptionParser::MissingArgument => m
					puts opts.to_s + "\n"
					exit
				rescue OptionParser::InvalidOption => i
					puts opts.to_s + "\n"
					exit
				end
			end

			# Main Application loop, handles all of the command line arguments and
			#parsing of files on the command line
			def run
				parse_options

				api = Middlecoin::Core::MiddlecoinAPI.new
				api.fetch_report

				ARGV.each do |address|
					begin
						puts "[*] Checking Address #{address}"
						Middlecoin::Core::BitcoinAddress.validate address

						result = api.lookup address

						if result == nil
							puts "[!] Address not found"
							next
						end

						puts "Address: #{result[:address]}"
						puts "Megahash/s: #{result[:megahashesPerSecond]}"
						puts "Rejected MHs: #{result[:rejectedMegahashesPerSecond]}"
						puts "Last hour shares: #{result[:lastHourShares]}"
						puts "Last hour rejected shares: #{result[:lastHourRejectedShares]}"
						puts "Immature Balance: #{result[:immatureBalance]}"
						puts "Unexchanged Balance: #{result[:unexchangedBalance]}"
						puts "Bitcoin Balance: #{result[:bitcoinBalance]}"
						puts "Total paid out: #{result[:paidOut]}\n"

					rescue Middlecoin::MiddlecoinAPIError => a
						puts "[!] Error: #{i.message}"
						break
					rescue Middlecoin::InvalidBitcoinAddressError => i
						puts "[!] Error: #{i.message}"
						next
					rescue => e
						puts e.inspect
						puts e.backtrace
						puts "[!] Error: #{address}"
						next
					end
				end
			end
		end
	end
end
