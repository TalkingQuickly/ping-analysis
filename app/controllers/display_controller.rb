class DisplayController < ApplicationController
	#extracts valid/ invalid packet data from the below file 
	#days are aggregated e.g. 9AM is 9 AM to 10AM across all
	#days present in the file. 
	
	before_filter :load_required_variables

	def all 
		f = File.open(@the_file) or die "Unable to open file..."
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
		render :file => @the_file
	end

	private

	def load_required_variables
		@the_file = "/Users/ben/08052011.txt"
	end
end
