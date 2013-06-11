require 'rubygems'
require 'bundler/setup'
require 'rack'
require 'sinatra'
require 'haml'
require 'less'
require 'mongo_mapper'
require 'mongo'
$stdout.sync = true if development?
require 'sinatra/reloader' if development?
require './model_task'
require './main'


run Sinatra::Application