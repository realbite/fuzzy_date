$:.unshift File.join(File.dirname(__FILE__),"..","lib")

require "test/unit"
require 'fuzzy_date'

class TestItem < Test::Unit::TestCase
  def test_basic_parse
    # complete date
    assert_not_nil(FuzzyDate.new)
    d1 = FuzzyDate.parse("Thurs 31 december 1998" )
    assert_equal(31, d1.day )
    assert_equal(12, d1.month )
    assert_equal(1998,d1.year)
    assert_equal(4, d1.wday )
    assert ( ! d1.bce?)
    assert ( ! d1.circa?)
    assert ( d1.complete?)
    assert ( !d1.unknown?)
    # empty
    d1 = FuzzyDate.parse("" )
    assert_nil( d1.day )
    assert_nil( d1.month )
    assert_nil(d1.year)
    assert ( ! d1.circa?)
    assert_equal(nil, d1.wday )
    assert ( ! d1.bce?)
    assert ( !d1.complete?)
    assert ( d1.unknown?)
    # just year
    d1 = FuzzyDate.parse("1540" )
    assert_nil( d1.day )
    assert_nil( d1.month )
    assert_equal(1540,d1.year)
    assert_equal(nil, d1.wday )
    assert ( ! d1.bce?)
    assert ( !d1.complete?)
    assert ( ! d1.circa?)
    assert ( !d1.unknown?)
    # just month
    d1 = FuzzyDate.parse("september" )
    assert_nil( d1.day )
    assert_equal(9, d1.month )
    assert_nil(d1.year)
    assert_equal(nil, d1.wday )
    assert ( ! d1.bce?)
    assert ( !d1.complete?)
    assert ( ! d1.circa?)
    assert ( !d1.unknown?)
    # just weekday
    d1 = FuzzyDate.parse("tuesday" )
    assert_equal(nil, d1.day )
    assert_equal(2, d1.wday )
    assert_nil( d1.month )
    assert_nil(d1.year)
    assert ( ! d1.bce?)
    assert ( !d1.complete?)
    assert ( ! d1.circa?)
    assert ( !d1.unknown?)
    # circa
    d1 = FuzzyDate.parse("c sunday 1066" )
    assert_equal(nil, d1.day )
    assert_equal(0, d1.wday )
    assert_nil( d1.month )
    assert_equal(1066,d1.year)
    assert ( ! d1.bce?)
    assert ( !d1.complete?)
    assert ( d1.circa?)
    assert ( !d1.unknown?)
    # bce
    d1 = FuzzyDate.parse(" 23 march 366 bc" )
    assert_equal(23, d1.day )
    assert_equal(nil, d1.wday )
    assert_equal(3, d1.month )
    assert_equal(366,d1.year)
    assert ( d1.bce?)
    assert ( d1.complete?)
    assert ( !d1.circa?)
    assert ( !d1.unknown?)
  end
  
  def test_database
    10000.times do 
      d = make_fuzzy_date
      puts d.to_s
      i = d.to_i
      i = i * 1 # reformat ?
      d2 = FuzzyDate.new_from_db( i )
      assert_equal( d.to_i, d2.to_i)
    end
  end
  
  def test_compare
    assert( FuzzyDate.parse("23 april 2000") == FuzzyDate.parse("23 april 2000") )
    assert( FuzzyDate.parse("24 april 2000") > FuzzyDate.parse("23 april 2000") )
    assert( FuzzyDate.parse("april 2000") > FuzzyDate.parse("march 2000") )
    assert( FuzzyDate.parse("jan 2001") > FuzzyDate.parse("dec 2000") )
    assert( FuzzyDate.parse("sept") > FuzzyDate.parse("july") )
  end
  
  # generate a random fuzzy date
  def make_fuzzy_date
    #    1  2  3  4  5  6  7  8  9  10 11 12
    tab=[31,28,31,30,31,30,31,31,30,31,30,31]
    year      = rand(2000)
    month     = rand(12) + 1
    wday      = rand(7)
    day       = rand(tab[month-1]) + 1
    circa     = rand(4) == 0
    bce       = rand(2) == 0
    do_year   = rand(3) > 0
    do_month  = rand(3) > 0
    do_day    = rand(3) > 0
    do_wday   = rand(3) > 0
    
    year = - year if bce
    FuzzyDate.new( do_year && year,
                   do_month && month,
                   do_day && day,
                   do_wday && wday,
                   circa)
  end
end
