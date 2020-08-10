module Extra
  def to_int(x)
    if x
      x = x.strip
      return nil if x==""
      x.to_i
    end
  end
  
  def to_bool(x)
    if x
      x = x.strip.downcase
      return true if x=="true"
      return true if x=="yes"
      false
    end
  end
  
  class FuzzyDate2 < FuzzyDate
    def initialize(*args)
      puts ">>>>>#{args.inspect}"
      super(*args)
    end
  end
  
  def make_fuzzy_date
    #    1  2  3  4  5  6  7  8  9  10 11 12
    tab=[31,28,31,30,31,30,31,31,30,31,30,31]
    year      = rand(3000)
    month     = rand(12) + 1
    wday      = rand(7)
    day       = rand(tab[month-1]) + 1
    circa     = rand(4) == 0
    bce       = rand(2) == 0
    do_year   = rand(3) > 0
    do_month  = rand(3) > 0
    do_day    = (rand(3) > 0) && do_month
    do_wday   = (rand(3) > 0) && !do_day
    
    year = - year if bce
    FuzzyDate2.new( do_year && year,
                   do_month && month,
                   do_day && day,
                   do_wday && wday,
                   circa)
  end
end

World(Extra) 
