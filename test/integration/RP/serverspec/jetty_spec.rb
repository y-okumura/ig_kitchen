require 'serverspec'
set :backend, :exec

describe user('jetty') do
  it { should exist }
end

describe service('jetty') do
  it { should be_enabled }
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end
