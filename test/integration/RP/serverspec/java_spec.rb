require 'serverspec'

set :backend, :exec

describe command('echo $JAVA_HOME') do
  its(:stdout) { should contain '/opt/local/jdk' }
end

describe command('/opt/local/jdk/bin/java -version') do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should contain '1.8.0' }
end
