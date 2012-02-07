require 'whysoslow/results'

module WhySoSlow

  class Runner

    attr_accessor :desc, :verbose, :time_unit, :memory_unit

    def initialize(desc, opts={})
      self.ios = opts[:ios] || $stdout
      @desc = desc.to_s
      @verbose = !!opts[:verbose]
      @time_unit = opts[:time_unit]
      @memory_unit = opts[:memory_unit]
      @results = nil
    end

    def ios=(io)
      io.sync = true
      @ios = io
    end

    def run(&block)
      Results.new(@desc, @time_unit, @memory_unit).tap do |results|
        @results = results
        if @verbose
          @ios.print 'whysoslow?'
        end
        self.snapshot('start')
        @results.benchmark(&block)
        self.snapshot('finish')
        if @verbose
          @ios.print "!\n\n"
        end
        @results = nil
      end
    end

    def snapshot(*args)
      raise RuntimeError, "no active results being gathered - be sure and call snapshot during a run session" if @results.nil?
      @results.snapshot(*args)
      @ios.print '.' if @verbose
    end

  end
end

