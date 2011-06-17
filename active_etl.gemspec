# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{active_etl}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Alessandro Berardi,,,"]
  s.date = %q{2011-06-09}
  s.email = %q{berardialessandro@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["Gemfile.lock", "Rakefile", "Gemfile", "LICENSE", "README", "lib/active_etl/attribute_source.rb", "lib/active_etl/job_execution_graph.rb", "lib/active_etl/source.rb", "lib/active_etl/transformation.rb", "lib/active_etl/source_model.rb", "lib/active_etl/destination_model.rb", "lib/active_etl/destination_dependencies_tree.rb", "lib/active_etl/job.rb", "lib/active_etl/proc_transformation.rb", "lib/active_etl/destination.rb", "lib/active_etl/engine.rb", "lib/active_etl/support/tree_node.rb", "lib/active_etl/support/hash_wrapper.rb", "lib/active_etl.rb"]
  s.homepage = %q{https://github.com/AlessandroBerardi/active_etl}
  s.rdoc_options = ["--main", "README"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{ActiveRecord based data warehousing ETL tool}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["~> 2.3.12"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["~> 2.3.12"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["~> 2.3.12"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
  end
end
