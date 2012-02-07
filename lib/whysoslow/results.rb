require 'whysoslow/measurement'
require 'whysoslow/memory_profile'

module WhySoSlow
  class Results

    attr_reader :desc

    def initialize(desc, time_unit, memory_unit)
      @desc = desc
      @measurement = Measurement.new(time_unit)
      @memory_profile = MemoryProfile.new(memory_unit)
    end

    def benchmark(*args, &block)
      @measurement.benchmark(*args, &block)
    end

    def snapshot(*args)
      @memory_profile.snapshot(*args)
    end

    def snapshots
      @snapshots ||= @memory_profile.snapshots
    end

    def snapshot_units
      @memory_profile.units
    end

    def snapshot_labels
      snapshots.collect{|s| s.label }
    end

    def snapshot_usages
      snapshots.collect{|s| s.memory }
    end

    def snapshot_diffs
      prev = nil
      snapshots.inject([]) do |diffs, snapshot|
        if prev.nil? || prev.memory == 0
          diffs << ['??', '??']
        else
          diff = snapshot.memory - prev.memory
          diffs << [
            diff,
            diff.to_f / prev.memory.to_f
          ]
        end
        prev = snapshot
        diffs
      end
    end

    def measurements
      @measurements ||= Measurement::MEASUREMENTS.collect do |m|
        [m, @measurement.send(m)]
      end
    end

    def measurement_units
      @measurement.units
    end

  end
end
