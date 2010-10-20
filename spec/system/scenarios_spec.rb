require 'spec'
require 'pathname'

all_dir = Pathname.new("#{File.dirname __FILE__}/scenarios")
Dir.glob "#{all_dir}/**/*/" do |this_dir|
  relative_path = Pathname.new(this_dir).relative_path_from(all_dir).to_s
  context_name = relative_path.split('/').join(' ').gsub('_', ' ')
  describe context_name do
    define_method :content do |filename|
      path = "#{this_dir}/#{filename}"
      return nil unless File.file?(path)
      content = File.read(path)
      return nil if content.empty?
      content
    end

    define_method :run_and_capture do |*args|
      options = args.first || {}
      stdin_filename = "#{this_dir}/stdin"
      htty_filename = "#{File.dirname __FILE__}/../../bin/htty"
      stderr_target = options[:combine_stdout_and_stderr] ?
                      '&1'                                :
                      "#{this_dir}/actual_stderr"
      arguments = "#{content 'arguments'} 2>#{stderr_target}"
      stdout_filename = "#{this_dir}/actual_stdout"
      system "cat #{stdin_filename} | "         +
             "#{htty_filename} #{arguments} > " +
             "#{this_dir}/actual_stdout"
    end

    it 'should produce the expected stdout' do
      run_and_capture
      content('actual_stdout').should == content('expected_stdout')
    end

    it 'should produce the expected stderr' do
      run_and_capture
      content('actual_stderr').should == content('expected_stderr')
    end

    it 'should produce the expected combined stdout and stderr' do
      run_and_capture :combine_stdout_and_stderr => true
      content('actual_stdout_and_stderr').should ==
      content('expected_stdout_and_stderr')
    end
  end
end
