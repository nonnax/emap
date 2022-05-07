#!/usr/bin/env ruby
# Id$ nonnax 2022-05-07 13:09:18 +0800
require_relative '../lib/emap'

EMap.define do

  erb '/',
      :index,
      layout: :'views/layout', time: Time.now

  erb '/home', '<h1>hello</h1>'

  erb '/404',
      'not found handler',
      layout: :'views/layout'
end

