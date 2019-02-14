Gem::Specification.new do |s|
  s.name = 'jekyll_remote_include'
  s.version = '0.1.6'
  s.summary = 'jekyll_remote_include'
  s.description = 'Import remote markdown from URLs like GitHub README.md into Jekyll'
  s.authors = ['Moesif, Inc', 'Derric Gilling']
  s.email = 'derric@moesif.com'
  s.homepage = 'https://moesif.com'
  s.license = 'Apache-2.0'
  s.add_dependency('jekyll', '~> 3.3.0')
  s.required_ruby_version = '~> 2.0'
  s.files = Dir['{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*']
  s.require_paths = ['lib']
end
