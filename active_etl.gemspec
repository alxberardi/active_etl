# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_etl}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alessandro Berardi,,,"]
  s.date = %q{2011-03-16}
  s.email = %q{berardialessandro@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["Gemfile.lock", "Rakefile", "Gemfile", "LICENSE", "README"]
  s.homepage = %q{https://github.com/AlessandroBerardi/active_etl}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{ActiveRecord based data warehousing ETL tool}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["~> 3.0.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["~> 3.0.0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
  end
end
