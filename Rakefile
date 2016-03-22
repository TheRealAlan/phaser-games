require 'rake'

desc "Build the website from source"
task :build do
  puts "## Building website"
  status = system("middleman build --clean")
  puts status ? "OK" : "FAILED"
end

desc "Run the server at http://localhost:4567"
task :server do
  system("middleman server")
end
