require 'benchmark'

module WhySoSlow
  class Measurement

    MEASUREMENTS = [:user, :system, :total, :real]
    attr_reader :units, :multiplier
    attr_reader *MEASUREMENTS

    def initialize(units='ms')
      @user, @system, @total, @real = 0
      @units, @multiplier = if units == 's'
        ['s', 1]
      else # MB
        ['ms', 1000]
      end
    end

    def benchmark(&block)
      Benchmark.measure(&block).tap do |values|
        measurments = values.to_s.strip.gsub(/[^\s|0-9|\.]/, '').split(/\s+/)
        self.user, self.system, self.total, self.real = measurments
      end
    end

    protected

    def user=(value_in_secs);   @user   = value_in_secs.to_f * @multiplier; end
    def system=(value_in_secs); @system = value_in_secs.to_f * @multiplier; end
    def total=(value_in_secs);  @total  = value_in_secs.to_f * @multiplier; end
    def real=(value_in_secs);   @real   = value_in_secs.to_f * @multiplier; end

  end
end
