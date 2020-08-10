Then(/^parse the following dates :$/) do |table|
  table.hashes.each do |h|
    f = FuzzyDate.parse(h["date"])
    f.year.should eql( to_int(h["year"]))  , "Invalid Year=#{f.year}!"
    f.month.should eql( to_int(h["month"]))  , "Invalid Month=#{f.month}!"
    f.day.should eql(  to_int(h["day"]))  , "Invalid Day=#{f.day}!"
    f.wday.should eql(  to_int(h["wday"]))  , "Invalid WeekDay=#{f.wday}!"
    f.bce?.should eql(  to_bool(h["bce?"]))  , "Invalid BCE=#{f.bce?}!"
    f.circa?.should eql(  to_bool(h["circa?"]))  , "Invalid CIRCA=#{f.circa?}!"
    f.complete?.should eql(  to_bool(h["complete?"]))  , "Invalid COMPLETE=#{f.complete?}!" if h.key?("complete?")
    f.unknown?.should eql(  to_bool(h["unknown?"]))  , "Invalid UNKNOWN=#{f.unknown?}!"    if h.key?("unknown?")
  end
end


Then(/^parse "(.*?)" random dates$/) do |count|
  count.to_i.times do
    f = make_fuzzy_date
    puts f.to_s
    f2 = FuzzyDate.parse(f.to_s)
    f2.to_db.should == f.to_db
  end
end
