describe command('curl http://localhost:8080/') do
  its(:stdout) { should contain 'Welcome to Open Identity Gateway 4.0.0' }
end
