#!/usr/bin/env bash
# Id$ nonnax 2022-03-21 21:31:49 +0800
require_relative 'app'

use Rack::Static,
  :urls => ["/images", "/js", "/css"],
  :root => "public"

pp EMap.map

run EMap.new
