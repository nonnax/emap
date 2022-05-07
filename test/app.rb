#!/usr/bin/env ruby
# Id$ nonnax 2022-05-07 13:09:18 +0800
require 'emap'
require_relative 'lib/model'

database=DB::load

Router.define do

  erb '/',
      :index,
      layout: :'views/layout', time: Time.now

  erb '/show', :'views/show',
      item:1,
      layout: :'views/layout'

  erb '/about',
      'under construction',
      layout: :'views/layout'

  erb '/404',
      'not found handler',
      layout: :'views/layout'
end

App=EMap.get do |body, **params|
    p [body.size, params]
    erb body, **params.merge(db: database)
end


pp App.routes
