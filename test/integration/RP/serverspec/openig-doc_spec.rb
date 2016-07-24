describe command('curl http://localhost:8081/') do
  its(:stdout) { should contain 'src="https://forgerock.org/openig/"' }
end
