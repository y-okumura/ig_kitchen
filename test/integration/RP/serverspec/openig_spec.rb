describe command('curl http://www.example.com:8080/') do
  its(:stdout) { should contain 'src="https://forgerock.org/openig/"' }
end

describe command('curl http://www.example.com:8080/static') do
  its(:stdout) { should match /Username.*\n.*demo/ }
end
