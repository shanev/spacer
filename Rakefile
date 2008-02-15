# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'spacer'

task :default => 'test:run'

PROJ.name = 'spacer'
PROJ.authors = 'Shane Vitarana'
PROJ.email = 'shanev@gmail.com'
PROJ.url = 'http://shanesbrain.net'
PROJ.rubyforge_name = 'spacer'
PROJ.version = Spacer::VERSION
PROJ.dependencies = ['oauth']

PROJ.spec_opts << '--color'

# EOF
