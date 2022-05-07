#!/usr/bin/env bash
# Id$ nonnax 2022-03-21 21:31:49 +0800
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

class EMap
  class Response<Rack::Response; end
  attr :data, :req, :res

  def self.define(&block)
    Router.define(&block)
  end

  def routes
    Router::map
  end

  def erb(name, **opts)
    View::erb(name, **opts)
  end

  def self.get(&block)
     new.tap{|o| o.get(&block)}
  end

  def get(&block)
     @get=block
  end

  def default
    not_found = routes['/404']
    status, body = 404, erb( (not_found&.first || 'Not Found'))
    [status, body]
  end

  def call env
    @req = Rack::Request.new(env)
    route = routes[env['PATH_INFO']]
    v, opts = route
    if route
      status, body = 200, View::path(v, default: v)
      # body = erb(body, **opts.merge(req.params).transform_keys(&:to_sym))
      body = instance_exec(body, **opts.merge(req.params).transform_keys(&:to_sym), &@get)
    else
      status, body = default
    end
    [status, {'Content-Type'  => 'text/html; charset=utf-8;', 'Cache-Control' => 'public, max-age=86400' }, [body] ]
  end
end

def EMap(&block)
  EMap.define(&block)
end
