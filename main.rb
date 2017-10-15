require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'openssl'
require 'jwt'


signing_key_path = File.expand_path("../key.rsa", __FILE__)
verify_key_path = File.expand_path("../key.rsa.pub", __FILE__)

signing_key = ""
verify_key = ""

File.open(signing_key_path) do |file|
  signing_key = OpenSSL::PKey.read(file)
end

File.open(verify_key_path) do |file|
  verify_key = OpenSSL::PKey.read(file)
end

set :signing_key, signing_key
set :verify_key, verify_key

enable :sessions

set :session_secret, 's3cr3t' 

require './helpers/helpers'
require './controllers/login'

