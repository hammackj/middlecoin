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
	module Core

		# Bitcoin Address
		class BitcoinAddress

			# Does some simple validation of a BTC address to make sure its sane
			def self.validate address
				if address[0] != "1" && address[0] != "3"
					raise Middlecoin::InvalidBitcoinAddressError, "Bitcoin addresses must start with 1 or 3"
				end

				if !(27..34).include?(address.length)
					raise Middlecoin::InvalidBitcoinAddressError, "Bitcoin addresses must be between 27 and 34 in length"
				end

				if address =~ /\A\p{Alnum}+\z/
					return true
				else 
					raise Middlecoin::InvalidBitcoinAddressError, "Bitcoin addresses must only contain Alphanumerical characters"
				end
			end
		end
	end
end
