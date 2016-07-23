describe command('curl http://localhost:8081/') do
  its(:stdout) { should contain '<title>Howdy, Anonymous User</title>' }
end
