#!/usr/bin/env bash
# Id$ nonnax 2022-03-21 21:31:49 +0800
require 'erb'
class EMap
  @map={}

  def self.erb(url, v, **opts)
    @map[url]=[v, opts]
  end

  def self.define(&block)
    instance_eval(&block)
  end

  def self.map
    @map
  end

  def path(f, default: '')
    xpath=File.expand_path("public/#{f}.erb", Dir.pwd)
    File.read(xpath) rescue default
  end

  def erb(name, **opts)
    layout=opts[:layout]
    layout=path(layout, default:'<%=yield%>')
    render(layout, **opts){
      render(name, binding, **opts)
    }
  end

  def render(name, b=binding, **opts)
    ERB.new(name).result(b)
  end

  def default
    not_found = self.class::map['/404']
    status, body = 404, erb( (not_found&.first || 'Not Found'), layout: :'/views/layout')
    [status, body]
  end

  def call env
    route = self.class::map[env['PATH_INFO']]
    request_method = env['REQUEST_METHOD']
    v, opts = route
    if route && request_method=='GET'
      status = 200
      body = path(v, default: v)
      body = erb( body, **opts)
    else
      status, body = default
    end
    [status, {'Content-Type'  => 'text/html; charset=utf-8;', 'Cache-Control' => 'public, max-age=86400' }, [body] ]
  end
end

def EMap(&block)
  EMap.define(&block)
end
