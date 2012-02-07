module WhySoSlow

  class MemoryProfile

    class Snapshot; end

    attr_reader :snapshots, :divider
    attr_accessor :units

    def initialize(units='MB')
      @snapshots = []
      self.units = units
    end

    def units=(value)
      @units, @divider = if value == 'KB'
        ['KB', 1]
      else # MB
        ['MB', 1000]
      end
    end

    def snapshot(label)
      Snapshot.new(label, @divider).tap { |snap| @snapshots.push(snap) }
    end

  end

  class MemoryProfile::Snapshot

    attr_reader :label, :memory

    def initialize(label, divider)
      @label = label
      @memory = capture_memory_usage(divider)
    end

    protected

    def capture_memory_usage(divider)
      ((`ps -o rss= -p #{$$}`.to_i) / divider.to_f)
    end

  end

end
