Gem::Specification.new do |s|
  s.name = "ruby-tic-tac-toe-crazcalm"  # i.e. visualruby.  This name will show up in the gem list.
  s.version = "0.0.1"  # i.e. (major,non-backwards compatable).(backwards compatable).(bugfix)
	s.add_dependency "vrlib", ">= 0.0.1"
	s.add_dependency "gtk2", ">= 0.0.1"
	s.add_dependency "require_all", ">= 0.0.1"
	s.has_rdoc = false
  s.authors = ["Marcus Willock"] 
  s.email = "craazcalm@gmail.com" # optional
  s.summary = "Tic Tac Toe Clone" # optional
  s.homepage = "http://www.yoursite.org/"  # optional
  s.description = "Tic Tac Toe Game that allows for single player mode and 2 player mode." # optional
	s.executables = ['main.rb']  # i.e. 'vr' (optional, blank if library project)
	s.default_executable = ['main.rb']  # i.e. 'vr' (optional, blank if library project)
	s.bindir = ['.']    # optional, default = bin
	s.require_paths = ['.']  # optional, default = lib 
	s.files = Dir.glob(File.join("**", "*.{rb,glade}"))
	s.rubyforge_project = "nowarning" # supress warning message 
end
