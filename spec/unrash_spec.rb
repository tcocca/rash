require 'spec_helper'

describe Hashie::Unrash do
  subject {
    Hashie::Unrash.new({
      "var_one" => 1,
      "two" => 2,
      :three => 3,
      :var_four => 4,
      "five_hump_humps" => 5,
      :nested => {
        "nested_one" => "One",
        :two => "two",
        "nested_three" => "three"
      },
      "nested_two" => {
        "nested_two" => 22,
        :nested_three => 23
      },
      "spaced _Key" => "When would this happen?",
      " trailing_spaces " => "better safe than sorry",
      "extra___spaces" => "hopefully this never happens"
    })
  }

  it { should be_a(Hashie::Mash) }

  it "should create a new unrash where all the keys are camelcased instead of underscored" do
    subject.varOne.should == 1
    subject.two.should == 2
    subject.three.should == 3
    subject.varFour.should == 4
    subject.fiveHumpHumps.should == 5
    subject.nested.should be_a(Hashie::Unrash)
    subject.nested.nestedOne.should == "One"
    subject.nested.two.should == "two"
    subject.nested.nested_three.should == "three"
    subject.nestedTwo.should be_a(Hashie::Unrash)
    subject.nestedTwo.nestedTwo.should == 22
    subject.nestedTwo.nestedThree.should == 23
    subject.spacedKey.should == "When would this happen?"
    subject.trailingSpaces.should == "better safe than sorry"
    subject.extraSpaces.should == "hopefully this never happens"
  end

  it "should allow underscored accessors" do
    subject.var_one.should == 1
    subject.var_one = "once"
    subject.var_one.should == "once"
    subject.varOne.should == "once"
  end

  it "should allow underscored accessors on nested hashes" do
    subject.nested.nested_one.should == "One"
    subject.nested.nested_one = "once"
    subject.nested.nestedOne.should == "once"
  end

  it "should merge well with a Mash" do
    merged = subject.merge Hashie::Mash.new(
      :nested => {:fourTimes => "a charm"},
      :nested3 => {:helloWorld => "hi"}
    )

    merged.nested.four_times.should == "a charm"
    merged.nested.fourTimes.should == "a charm"
    merged.nested3.should be_a(Hashie::Unrash)
    merged.nested3.helloWorld.should == "hi"
    merged.nested3.hello_world.should == "hi"
    merged[:nested3][:helloWorld].should == "hi"
  end

  it "should update well with a Mash" do
    subject.update Hashie::Mash.new(
      :nested => {:four_times => "a charm"},
      :nested3 => {:hello_world => "hi"}
    )

    subject.nested.four_times.should == "a charm"
    subject.nested.fourTimes.should == "a charm"
    subject.nested3.should be_a(Hashie::Unrash)
    subject.nested3.hello_world.should == "hi"
    subject.nested3.helloWorld.should == "hi"
    subject[:nested3][:hello_world].should == "hi"
  end

  it "should merge well with a Hash" do
    merged = subject.merge({
      :nested => {:fourTimes => "work like a charm"},
      :nested3 => {:helloWorld => "hi"}
    })

    merged.nested.four_times.should == "work like a charm"
    merged.nested.fourTimes.should == "work like a charm"
    merged.nested3.should be_a(Hashie::Unrash)
    merged.nested3.hello_world.should == "hi"
    merged.nested3.helloWorld.should == "hi"
    merged[:nested3][:helloWorld].should == "hi"
  end

  it "should handle assigning a new Hash and convert it to a unrash" do
    subject.nested3 = {:helloWorld => "hi"}

    subject.nested3.should be_a(Hashie::Unrash)
    subject.nested3.hello_world.should == "hi"
    subject.nested3.helloWorld.should == "hi"
    subject[:nested3][:helloWorld].should == "hi"
  end

  it "should allow initializing reader" do
    subject.nested3!.helloWorld = "hi"
    subject.nested3.hello_world.should == "hi"
  end

end
