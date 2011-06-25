Given 'an htty session' do
  Given 'I run "htty" interactively'
end

Given /^an htty session with (\S+)$/ do |url|
  When %Q{I run "htty #{url}" interactively}
end

Then 'I should see the 200 OK output' do
  Then 'the output should match:',
       '200.+? OK -- \d+ headers? -- \d+-character body'
end

Then 'I should see the goodbye output' do
  Then 'the output should contain:', '*** Happy Trails To You!'
end
