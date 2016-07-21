require 'serverspec'
set :backend, :exec

describe user('jetty') do
  it { should exist }
end

describe service('jetty') do
  it { should be_enabled }
  it { should be_running }
end
