require 'ansi'

module Whysoslow
  class DefaultPrinter

    def initialize(*args)
      @opts, @ios = [
        args.last.kind_of?(::Hash) ? args.pop : {},
        args.pop || $stdout
      ]
      @ios.sync = true
      @title = @opts[:title]
      @verbose = @opts[:verbose]
    end

    def print(thing)
      case thing
      when :title
        if @title
          @ios.puts @title.to_s
          @ios.puts '-'*(@title.to_s.length)
        end
      when :run_start
        @ios.print "whysoslow? " if @verbose
      when :snapshot
        @ios.print '.' if @verbose
      when :run_end
        @ios.print "\n\n" if @verbose
      when Whysoslow::Results
        @ios << snapshots_table(thing)
        @ios.puts
        @ios << measurements_table(thing)
      else
      end
    end

    protected

    def snapshots_table(results)
      units = results.snapshot_units
      tdata = [
        results.snapshot_labels.collect { |l| "mem @ #{l}" },
        results.snapshot_usages.collect { |u| "#{memory_s(u)} #{units}" },
        results.snapshot_diffs.collect do |diff_perc|
          diff = diff_perc.first
          perc = diff_perc.last
          if diff == '??'
            "??"
          elsif diff > 0
            ANSI.red do
              "+#{memory_s(diff.abs)} #{units}, #{perc_s(perc)}%"
            end
          else
            ANSI.green do
              "-#{memory_s(diff.abs)} #{units}, #{perc_s(perc)}%"
            end
          end
        end
      ].flatten
      ANSI::Columns.new(tdata, {
        :columns => 3,
        :align => :left,
        :padding => 1
      }).to_s
    end

    def measurements_table(results)
      units = results.measurement_units
      tdata = [
        ['', 'time'],
        results.measurements.collect do |l_t|
          [l_t.first, "#{l_t.last} #{units}"]
        end
      ].flatten
      ANSI::Columns.new(tdata, :columns => 5, :align=>:left).to_s
    end

    def snapshots_label_col
      results.snapshots.collect{|r| "mem @ #{r.label}" }
    end

    def memory_s(amount)
      amount.round.to_s.rjust(4)
    end

    def perc_s(perc)
      (perc*100).round.abs.to_s.rjust(3)
    end

  end
end
