require 'ansi'

module WhySoSlow
  class DefaultPrinter

    def initialize(results)
      @results = results
    end

    def print(ios=$stdout, opts={})
      ios.sync = true
      puts @results.desc.to_s
      puts '-'*(@results.desc.to_s.length)

      ios << snapshots_table
      ios.puts
      ios << measurements_table
    end

    protected

    def snapshots_table
      units = @results.snapshot_units
      tdata = [
        @results.snapshot_labels.collect { |l| "mem @ #{l}" },
        @results.snapshot_usages.collect { |u| "#{memory_s(u)} #{units}" },
        @results.snapshot_diffs.collect do |diff_perc|
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

    def measurements_table
      units = @results.measurement_units
      tdata = [
        ['', 'time'],
        @results.measurements.collect do |l_t|
          [l_t.first, "#{l_t.last} #{units}"]
        end
      ].flatten
      ANSI::Columns.new(tdata, :columns => 5, :align=>:left).to_s
    end

    def snapshots_label_col
      @results.snapshots.collect{|r| "mem @ #{r.label}" }
    end

    def memory_s(amount)
      amount.round.to_s.rjust(4)
    end

    def perc_s(perc)
      (perc*100).round.abs.to_s.rjust(3)
    end

  end
end
  # def to_s(meas, label)
  #   # puts @desc.to_s
  #   # puts '-'*(@desc.to_s.length)
  #   if meas == :memory
  #     "#{label_s(label)}:  #{memory_s(@memory_usage[:curr])} MB  #{"(#{memory_basis_s})"}"
  #   else
  #     "#{label_s(label)}:  #{time_s(meas)} ms"
  #   end
  # end

  # protected

  # def label_s(label); label.rjust(25); end
  # def time_s(meas); self.send(meas).to_s.rjust(12); end
  # def memory_s(amount)
  #   amount.to_s.rjust(6)
  # end
  # def perc_s(perc)
  #   (perc*100).round.abs.to_s.rjust(3)
  # end

  # def memory_basis_s
    # if @memory_usage[:prev] == 0
    #   "??"
    # else
    #   diff = (@memory_usage[:curr] - @memory_usage[:prev])
    #   perc = diff.to_f / @memory_usage[:prev].to_f

    # if diff > 0
    #   ANSI.red   + "+#{memory_s(diff.abs)} MB, #{perc_s(perc)}%" + ANSI.reset
    # else
    #   ANSI.green + "-#{memory_s(diff.abs)} MB, #{perc_s(perc)}%" + ANSI.reset
    # end
    # end
  # end
