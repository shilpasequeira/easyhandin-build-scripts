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

java_file_paths = []
Find.find(Dir.pwd) do |path|
    java_file_paths << path if path =~ /.*\.java$/
end

java_file_paths.each do|a|
    MossRuby.add_file(to_check, a)
end


# Get server to process files
url = moss.check to_check



# Get results
results = moss.extract_results url

# Use results
puts "Got results from #{url}"

Launchy.open(url)


