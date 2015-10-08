namespace :lib do
  desc "Check the source for missing 'require' statements. Set the 'VERBOSE' " +
       'environment variable to "t[rue]" to display the name of each file as ' +
       'it is loaded.'
  task :each do
    def verbose?
      ENV['VERBOSE'].to_s =~ /^T/i
    end

    Dir.chdir 'lib' do
      Dir.glob( '**/*.rb' ) do |f|
        next if f == 'tasks.rb'

        if verbose?
          puts "* #{f}"
        else
          print "\e[32m.\e[0m"
        end
        command = "/usr/bin/env ruby -e 'require File.expand_path(#{f.inspect})'"
        break unless system(command)
      end
    end
    puts unless verbose?
  end
end
