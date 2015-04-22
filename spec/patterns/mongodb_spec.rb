# encoding: utf-8
require "spec_helper"
require "logstash/patterns/core"

describe "MONGO3_LOG" do

  let(:value)      { "2014-11-03T18:28:32.450-0500 I NETWORK [initandlisten] waiting for connections on port 27017" }
  let(:pattern)    { "MONGO3_LOG" }
  subject(:groked) { grok_match(pattern, value) }

  it "generates a timestamp field" do
    expect(groked).to include("timestamp" => "2014-11-03T18:28:32.450-0500")
  end

  it "generates a severity field" do
    expect(groked).to include("severity" => "I")
  end

  it "generates a component field" do
    expect(groked).to include("component" => "NETWORK")
  end

  it "generates a context field" do
    expect(groked).to include("context" => "initandlisten")
  end

  it "generates a message field" do
    expect(groked["message"]).to include("waiting for connections on port 27017")
  end

end
