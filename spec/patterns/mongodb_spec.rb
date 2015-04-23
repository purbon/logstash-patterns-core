# encoding: utf-8
require "spec_helper"
require "logstash/patterns/core"

describe "MONGO3_LOG" do

  let(:pattern)    { "MONGO3_LOG" }

  context "parsing '2014-11-03T18:28:32.450-0500 I NETWORK [initandlisten] waiting for connections on port 27017'" do
    let(:value)      { "2014-11-03T18:28:32.450-0500 I NETWORK [initandlisten] waiting for connections on port 27017" }
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

  context "parsing '2015-02-24T18:17:47.148+0000 F -        [conn11] Got signal: 11 (Segmentation fault).'" do
    let(:value)      { "2015-02-24T18:17:47.148+0000 F -        [conn11] Got signal: 11 (Segmentation fault)." }
    subject(:groked) { grok_match(pattern, value) }

    it "generates a timestamp field" do
      expect(groked).to include("timestamp" => "2015-02-24T18:17:47.148+0000")
    end

    it "generates a severity field" do
      expect(groked).to include("severity" => "F")
    end

    it "generates a component field" do
      expect(groked).to include("component" => "-")
    end

    it "generates a context field" do
      expect(groked).to include("context" => "conn11")
    end

    it "generates a message field" do
      expect(groked["message"]).to include("Got signal: 11 (Segmentation fault).")
    end
  end

end
