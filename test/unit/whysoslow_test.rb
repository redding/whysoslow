require 'assert'
require 'whysoslow'

module Whysoslow

  class UnitTests < Assert::Context
    desc "Whysoslow"

    # no tests right now - all this does is make sure you can load it

    should "load" do
      assert_equal false, require('whysoslow')
    end

  end

end
