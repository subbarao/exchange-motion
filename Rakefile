# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'
require 'bundler'
Bundler.require

require 'bubble-wrap/all'
#require 'bubble-wrap/test'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'login-info'
  app.vendor_project('vendor/Frank', :static)
  app.frameworks += %w(QuartzCore CFNetwork)
  app.pods do
    pod 'JSONKit'
    pod 'PullToRefresh'
  end
end
