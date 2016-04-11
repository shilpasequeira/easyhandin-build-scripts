#!/usr/bin/env ruby

puts "--- Moss process started"
require 'moss_ruby'
require 'find'

# Create the MossRuby object
moss = MossRuby.new(432822968) #replace 000000000 with your user id

# Set options  -- the options will already have these default values
moss.options[:max_matches] = 10
moss.options[:directory_submission] = true
moss.options[:show_num_matches] = 250
moss.options[:experimental_server] = false
moss.options[:comment] = ""
moss.options[:language] = ENV["LANGUAGE"]
file_extension = ENV["FILE_EXTENSION"]


# Create a file hash, with the files to be processed
to_check = MossRuby.empty_file_hash

Find.find(Dir.pwd) do |path|
  if path =~ /.*\.#{file_extension}$/
    path.slice!(Dir.pwd+ "/")
    MossRuby.add_file(to_check, path)
  end
end

Find.find("skeletonFolder") do |path|
  if path =~ /.*\.#{file_extension}$/
    path.slice!(Dir.pwd+ "/")
    MossRuby.add_base_file(to_check, path)
  end
end

# Get server to process files
url = moss.check to_check

# Get results
results = moss.extract_results url

# Use results
puts "MOSS RESULT@#{url}"

