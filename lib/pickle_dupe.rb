require 'pickle'
require 'pickle_dupe/adapter'
require 'pickle_dupe/session'
require 'pickle_dupe/session/parser'

# make the parser aware of models in the session (for fields refering to models)
Pickle::Parser.send :include, Pickle::Session::Parser
