# -*- coding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "entropicrune-metric_fu"
  s.version     = "2.1.3"
  s.summary     = "A fistful of code metrics, with awesome templates and graphs"
  s.email       = "jake.scruggs@gmail.com"
  s.homepage    = "http://metric-fu.rubyforge.org/"
  s.description = "Code metrics from Flog, Flay, RCov, Saikuro, Churn, Reek, Roodi, Rails' stats task and Rails Best Practices"
  s.authors     = ["Jake Scruggs", "Sean Soper", "Andre Arko", "Petrik de Heus", "Grant McInnes", "Nick Quaranto", "Édouard Brière", "Carl Youngblood", "Richard Huang", "Dan Mayer"]

  s.files = ["README","HISTORY","TODO","MIT-LICENSE","Rakefile"]

  # Dir['lib/**/*.*'] + Dir['tasks/*.*']
  s.files += ["lib/base/base_template.rb", "lib/base/churn_analyzer.rb", "lib/base/code_issue.rb", "lib/base/configuration.rb", "lib/base/flay_analyzer.rb", "lib/base/flog_analyzer.rb", "lib/base/generator.rb", "lib/base/graph.rb", "lib/base/line_numbers.rb", "lib/base/location.rb", "lib/base/md5_tracker.rb", "lib/base/metric_analyzer.rb", "lib/base/ranking.rb", "lib/base/rcov_analyzer.rb", "lib/base/reek_analyzer.rb", "lib/base/report.rb", "lib/base/roodi_analyzer.rb", "lib/base/saikuro_analyzer.rb", "lib/base/scoring_strategies.rb", "lib/base/stats_analyzer.rb", "lib/base/table.rb", "lib/generators/churn.rb", "lib/generators/flay.rb", "lib/generators/flog.rb", "lib/generators/hotspots.rb", "lib/generators/rails_best_practices.rb", "lib/generators/rcov.rb", "lib/generators/reek.rb", "lib/generators/roodi.rb", "lib/generators/saikuro.rb", "lib/generators/stats.rb", "lib/graphs/engines/bluff.rb", "lib/graphs/engines/gchart.rb", "lib/graphs/flay_grapher.rb", "lib/graphs/flog_grapher.rb", "lib/graphs/grapher.rb", "lib/graphs/rails_best_practices_grapher.rb", "lib/graphs/rcov_grapher.rb", "lib/graphs/reek_grapher.rb", "lib/graphs/roodi_grapher.rb", "lib/graphs/stats_grapher.rb", "lib/metric_fu.rb", "lib/templates/awesome/awesome_template.rb", "lib/templates/awesome/churn.html.erb", "lib/templates/awesome/css/buttons.css", "lib/templates/awesome/css/default.css", "lib/templates/awesome/css/integrity.css", "lib/templates/awesome/css/reset.css", "lib/templates/awesome/css/syntax.css", "lib/templates/awesome/flay.html.erb", "lib/templates/awesome/flog.html.erb", "lib/templates/awesome/hotspots.html.erb", "lib/templates/awesome/index.html.erb", "lib/templates/awesome/layout.html.erb", "lib/templates/awesome/rails_best_practices.html.erb", "lib/templates/awesome/rcov.html.erb", "lib/templates/awesome/reek.html.erb", "lib/templates/awesome/roodi.html.erb", "lib/templates/awesome/saikuro.html.erb", "lib/templates/awesome/stats.html.erb", "lib/templates/javascripts/bluff-min.js", "lib/templates/javascripts/excanvas.js", "lib/templates/javascripts/js-class.js", "lib/templates/standard/churn.html.erb", "lib/templates/standard/default.css", "lib/templates/standard/flay.html.erb", "lib/templates/standard/flog.html.erb", "lib/templates/standard/hotspots.html.erb", "lib/templates/standard/index.html.erb", "lib/templates/standard/rails_best_practices.html.erb", "lib/templates/standard/rcov.html.erb", "lib/templates/standard/reek.html.erb", "lib/templates/standard/roodi.html.erb", "lib/templates/standard/saikuro.html.erb", "lib/templates/standard/standard_template.rb", "lib/templates/standard/stats.html.erb", "tasks/metric_fu.rake"]
  s.test_files = ["spec/base/base_template_spec.rb", "spec/base/configuration_spec.rb", "spec/base/generator_spec.rb", "spec/base/graph_spec.rb", "spec/base/line_numbers_spec.rb", "spec/base/md5_tracker_spec.rb", "spec/base/report_spec.rb", "spec/generators/churn_spec.rb", "spec/generators/flay_spec.rb", "spec/generators/flog_spec.rb", "spec/generators/rails_best_practices_spec.rb", "spec/generators/rcov_spec.rb", "spec/generators/reek_spec.rb", "spec/generators/roodi_spec.rb", "spec/generators/saikuro_spec.rb", "spec/generators/stats_spec.rb", "spec/graphs/engines/bluff_spec.rb", "spec/graphs/engines/gchart_spec.rb", "spec/graphs/flay_grapher_spec.rb", "spec/graphs/flog_grapher_spec.rb", "spec/graphs/rails_best_practices_grapher_spec.rb", "spec/graphs/rcov_grapher_spec.rb", "spec/graphs/reek_grapher_spec.rb", "spec/graphs/roodi_grapher_spec.rb", "spec/graphs/stats_grapher_spec.rb", "spec/resources/line_numbers/foo.rb", "spec/resources/line_numbers/module.rb", "spec/resources/line_numbers/module_surrounds_class.rb", "spec/resources/line_numbers/two_classes.rb", "spec/resources/saikuro/app/controllers/sessions_controller.rb_cyclo.html", "spec/resources/saikuro/app/controllers/users_controller.rb_cyclo.html", "spec/resources/saikuro/index_cyclo.html", "spec/resources/saikuro_sfiles/thing.rb_cyclo.html", "spec/resources/yml/20090630.yml", "spec/resources/yml/metric_missing.yml", "spec/spec.opts", "spec/spec_helper.rb"]

  # flay, flog and subdependencies
  s.add_dependency("flay", ["= 1.4.3"])
  s.add_dependency("flog", ["= 2.5.3"])
    s.add_dependency("ruby_parser", ["= 2.3.1"])
    s.add_dependency("sexp_processor", ["= 3.0.7"])  
  
  # rcov
  s.add_dependency("rcov", ["= 0.9.11"])
  
  # reek and subdependencies
  s.add_dependency("reek", ["= 1.2.8"])
    s.add_dependency("ruby2ruby", ["= 1.3.1"])
    # Also depends on ruby_parser and sexp_processor

  # roodi (also depends on ruby_parser)
  s.add_dependency("roodi", ["= 2.1.0"])

  # rails_best_practices and subdependencies
  s.add_dependency("rails_best_practices", ["= 1.7.2"])
    s.add_dependency("activesupport", ["= 3.1.3"])
    s.add_dependency("multi_json", ["= 1.3.6"]) # Dependency of activesupport
    s.add_dependency("colored", ["= 1.2"])
    s.add_dependency("erubis", ["= 2.7.0"])
    s.add_dependency("i18n", ["= 0.6.1"])
    s.add_dependency("progressbar", ["= 0.11.0"])
  # Also depends on sexp_processor

  # churn and subdependencies
  s.add_dependency("churn", ["= 0.0.15"])
    s.add_dependency("arrayfields", ["= 4.7.4"])
    s.add_dependency("chronic", ["= 0.6.7"])
    s.add_dependency("fattr", ["= 2.2.0"])
    s.add_dependency("hirb", ["= 0.5.0"])
    s.add_dependency("jeweler", ["= 1.6.4"]) # depends on bundler, git, rake
      s.add_dependency("bundler", ["= 1.2.1"])
      s.add_dependency("git", ["= 1.2.5"])
      s.add_dependency("rake", ["= 0.9.2.2"])
    s.add_dependency("json", ["= 1.6.1"])
    s.add_dependency("json_pure", ["= 1.7.5"])
    s.add_dependency("main", ["= 4.8.0"]) # depends on arrayfields, chronic, fattr, and map
    s.add_dependency("map", ["= 4.3.0"])
  # Also depends on ruby_parser and sexp_processor
  
  # atoulme-Saikuro
  s.add_dependency("atoulme-Saikuro", ["= 1.2.1"])  # The Saikuro-1.1.0 gem has error "such file to load -- rdoc/usage" on ruby 1.9.1p378 installed by rvm on OSX. Problem has existed for a year! atoulme-Saikuro fixes this problem.
  
  # syntax
  s.add_dependency("syntax", ["= 1.0.0"])
  


  # DEVELOPMENT DEPENDENCIES
  
  # rspec and subdependencies
  s.add_development_dependency("rspec", ["= 2.8.0"])
    s.add_development_dependency("rspec-core", ["= 2.8.0"])
    s.add_development_dependency("rspec-expectations", ["= 2.8.0"]) # depends on diff-lcs
      s.add_development_dependency("diff-lcs", ["= 1.1.3"])
    s.add_development_dependency("rspec-mocks", ["= 2.8.0"])
  
  # test-construct
  s.add_development_dependency("test-construct", ["= 1.2.0"])
  
  # googlecharts
  s.add_development_dependency("googlecharts", ["= 1.6.8"])
end
