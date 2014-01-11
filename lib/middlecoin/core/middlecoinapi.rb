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

require 'net/http'
require 'json'
require 'uri'

module Middlecoin
	module Core

		# Bitcoin Address
		class MiddlecoinAPI
			attr_accessor :report

			# Simple function for following redirects, found it on stackexchange
			def fetch(uri_str, limit = 10)
			  raise ArgumentError, 'HTTP redirect too deep' if limit == 0

			  url = URI.parse(uri_str)
			  req = Net::HTTP::Get.new(url.path, { 'User-Agent' => "Agent" })
			  
			  response = Net::HTTP.start(url.host, url.port) do |http| 
			  	http.request(req) 
			  end

			  case response
			  	when Net::HTTPSuccess
			  		then response
			  	when Net::HTTPRedirection 
			  		then fetch(response['location'], limit - 1)
			  	else
			    	response.error!
			  end
			end

			# Downloads and caches the report JSON from middlecoin.com
			def fetch_report
				begin
					report = fetch("#{Middlecoin::MIDDLECOIN_URL}/json")
					@report = JSON.parse(report.body)["report"]
				rescue => e
					raise Middlecoin::MiddlecoinAPIError, "Unable to collect JSON report from middlecoin.com"
				end
			end

			# Looks up a specific btc address in the JSON report from
			# middlecoin.com
			def lookup btc_address
				@report.each do |address|
					if address[0].eql?(btc_address)
						result = {
							:address => address[0],
							:lastHourShares => address[1]["lastHourShares"],
							:immatureBalance => address[1]["immatureBalance"],
							:lastHourRejectedShares => address[1]["lastHourRejectedShares"],
							:paidOut => address[1]["paidOut"],
							:unexchangedBalance => address[1]["unexchangedBalance"],
							:megahashesPerSecond => address[1]["megahashesPerSecond"],
							:bitcoinBalance => address[1]["bitcoinBalance"],
							:rejectedMegahashesPerSecond => address[1]["rejectedMegahashesPerSecond"]
						}

						return result
					end
				end

				return nil
			end
		end
	end
end
