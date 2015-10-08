Dir.glob "#{File.dirname __FILE__}/#{File.basename __FILE__, '.rb'}/*.rake" do |f|
  load f
end
