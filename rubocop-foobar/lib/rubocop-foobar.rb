# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/foobar'
require_relative 'rubocop/foobar/version'
require_relative 'rubocop/foobar/inject'

RuboCop::Foobar::Inject.defaults!

require_relative 'rubocop/cop/foobar_cops'
