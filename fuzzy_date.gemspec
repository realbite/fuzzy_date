require 'rubygems'


Gem::Specification.new do |s|
  
  s.name              = %q{fuzzy_date}
  s.version           = "0.8.3"
  s.platform          = Gem::Platform::RUBY
  s.author            = "Clive Andrews"
  s.date              = %q{2010-02-24}
  s.description       = %q{FuzzyDate is a Ruby class for working with incomplete dates.}
  s.email             = %q{pacman@realitybites.eu}
  s.homepage          = %q{http://site.realitybites.eu/content/fuzzy_date}
  
  s.files             = [ "README",  "lib/fuzzy_date.rb"]
  s.test_files        = [ "test/test_fuzzy_date.rb" ]
  
  s.has_rdoc          = true
  s.rdoc_options      = ["--charset=UTF-8"]

  
  s.require_paths     = ["lib"]
  s.rubyforge_project = %q{fuzzy_date}
  s.summary           = %q{FuzzyDate is a Ruby class for working with incomplete dates.Can be used in Combination with ActiveRecord.}
end


