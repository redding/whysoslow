require 'whysoslow/results'

module Whysoslow

  class Runner

    attr_accessor :desc, :verbose, :time_unit, :memory_unit

    def initialize(printer, opts={})
      @printer = printer
      @time_unit = opts[:time_unit]
      @memory_unit = opts[:memory_unit]
      @results = nil
    end

    def run(&block)
      @printer.print :title
      @printer.print(Results.new(@desc, @time_unit, @memory_unit).tap do |results|
        @results = results
        @printer.print :run_start
        self.snapshot('start')
        @results.benchmark(&block)
        self.snapshot('finish')
        @printer.print :run_end
        @results = nil
      end)
    end

    def snapshot(*args)
      raise RuntimeError, "no active results being gathered - be sure and call snapshot during a run session" if @results.nil?
      @results.snapshot(*args)
      @printer.print :snapshot
    end

  end
end

