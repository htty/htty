begin
  require 'rspec/core/rake_task'
rescue LoadError
else
  def define_spec_task(name, options={})
    desc options[:desc]
    begin
      require 'rspec/core/rake_task'
    rescue LoadError
    else
      RSpec::Core::RakeTask.new name do |t|
        t.rspec_opts ||= []
        t.rspec_opts << "--backtrace" if options[:backtrace]

        debugger_gem = %w(pry-byebug pry-debugger).detect do |gem|
          `bundle show #{gem} 2>&1 >/dev/null`
          $?.success?
        end
        if debugger_gem && options[:debug] != false
          t.rspec_opts << "--require #{debugger_gem}"
        end

        t.rspec_opts << "--format #{options[:format]}" if options.key?(:format)
        t.rspec_opts << '--no-profile' if options[:profile] == false
        t.rspec_opts << '--warnings' if options[:warnings]
        t.pattern = options[:pattern] || %w(spec/*_spec.rb spec/**/*_spec.rb)
      end
    end
  end

  define_spec_task :spec, desc: 'Run specs', profile: true

  namespace :spec do
    uncommitted_files_in_spec = `git ls-files --modified --others spec/* spec/**/*`.split("\n")
    uncommitted_spec_files = `git ls-files --modified --others spec/*_spec.rb spec/**/*_spec.rb`.split("\n")
    nonspec_uncommitted_files_in_spec = uncommitted_files_in_spec -
                                        uncommitted_spec_files
    if nonspec_uncommitted_files_in_spec.empty?
      if uncommitted_spec_files.empty?
        desc 'Run uncommitted specs (none)'
        task :uncommitted do
          puts 'No uncommitted specs to run'
        end
      else
        noun_phrase = "#{uncommitted_spec_files.length} uncommitted spec file#{(uncommitted_spec_files.length == 1) ? nil : 's'}"
        desc = "Run #{noun_phrase}"
        define_spec_task :uncommitted, desc:    desc,
                                       pattern: uncommitted_spec_files
      end
    else
      noun_phrase = "#{uncommitted_files_in_spec.length} uncommitted file#{uncommitted_files_in_spec.length == 1 ? nil : 's'}"
      desc = "Run all specs because of #{noun_phrase} in 'spec'"
      define_spec_task :uncommitted, desc: desc, pattern: 'spec'
    end

    define_spec_task :warnings, desc:     'Run specs with Ruby warnings enabled',
                                format:   :progress,
                                profile:  false,
                                warnings: true
  end

  # Support the 'gem test' command.
  define_spec_task :test, desc: '', backtrace: true,
                                    debug:     false,
                                    format:    :progress,
                                    profile:   false
end
