#!/usr/bin/env ruby
# Id$ nonnax 2022-05-07 17:15:44 +0800
require 'erb'

class Router
  @map={}
  class << self
    attr :map
    def erb(url, v, **opts)
      @map[url]=[v, opts]
    end

    def define(&block)
      instance_eval(&block)
    end
  end
end

class View
  class << self
    attr :data

    def path(f, default: '')
      xpath=File.expand_path("public/#{f}.erb", Dir.pwd)
      File.read(xpath) rescue default
    end

    def erb(name, **opts)
      @data = opts
      layout=opts[:layout]
      layout=path(layout, default:'<%=yield%>')
      name = path(name, default: name.to_s)
      render(layout){
        render(name, binding)
      }
    end

    def render(name, b=binding)
      ERB.new(name).result(b)
    end
  end
end
