#!/usr/bin/env ruby


require 'moss_ruby'
require 'find'

# Create the MossRuby object
moss = MossRuby.new(432822968) #replace 000000000 with your user id

# Set options  -- the options will already have these default values
moss.options[:max_matches] = 10
moss.options[:directory_submission] =  true
moss.options[:show_num_matches] = 250
moss.options[:experimental_server] =    false
moss.options[:comment] = ""
moss.options[:language] = "java"

# Create a file hash, with the files to be processed



to_check = MossRuby.empty_file_hash

ARGV.each do|a|
    MossRuby.add_file(to_check, a)
end



#assignments = ENV[ASSIGNMENTS_PATH]
#baseFile = ENV[BASEFILE_PATH]

#add to the base file
#if (baseFile != nil)
#   MossRuby.add_base_file(to_check, baseFile)
#end

#assignmentsArray = assignments.split(/\s*,\s*/)

#if (assignmentsArray != nil)
#    assignmentsArray.each do |a|
#        puts a
#        MossRuby.add_file(to_check, a)
#    end
#end


# Get server to process files
url = moss.check to_check



# Get results
results = moss.extract_results url

# Use results
puts "Got results from #{url}"
i = 0
results.each { |match|
    match.each { |file|
        logfile = File.new("results_" + i.to_s + ".html", 'w')
        logfile.puts "#{file[:filename]} #{file[:pct]} #{file[:html]}"
        i = i + 1
    }
}

