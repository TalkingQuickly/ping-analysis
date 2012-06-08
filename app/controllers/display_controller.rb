class DisplayController < ApplicationController
	def all 
		f = File.open("/Users/ben/08052011.txt") or die "Unable to open file..."
		contentsArray=[]  # start with an empty array
		f.each_line {|line|
			contentsArray.push line
		}

		@all = {}
		@all[:true] = 0
		@all[:false] = 0
		@output = {}
		contentsArray.each do |line|
			pieces = line.split(" ")
			valid = (pieces.length == 13 ? :true : :false)
			hour = pieces[3].split(":")[0]
			unless @output[hour.to_sym]
				@output[hour.to_sym] = {}
				@output[hour.to_sym][:true] = 0; 
				@output[hour.to_sym][:false] = 0; 
			end
			@output[hour.to_sym][valid] += 1
			@all[valid] += 1 
		end
	end

	def download
		render :file => "/Users/ben/08052011.txt"
	end
end
