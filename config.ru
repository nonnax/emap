#!/usr/bin/env bash
# Id$ nonnax 2022-03-21 21:31:49 +0800
require_relative 'emap'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

EMap.define do

  erb '/',     :hi,                 layout: :'views/layout', time: Time.now

  erb '/home', '<h1>hello</h1>'

  erb '/404',  'not found handler', layout: :'views/layout'
end

pp EMap.map

run EMap.new
