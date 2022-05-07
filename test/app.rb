#!/usr/bin/env ruby
# Id$ nonnax 2022-05-07 13:09:18 +0800
require_relative '../lib/emap'

database={item: [1, 2, 3], stock: 2}

Router.define do

  erb '/',
      :index,
      layout: :'views/layout', time: Time.now

  erb '/home', :'views/show', item:1, data: database

  erb '/404',
      'not found handler',
      layout: :'views/layout'
end

App=EMap.get do |body, **params|
    p [body, params]
    erb body, **params
end


pp Router.map
