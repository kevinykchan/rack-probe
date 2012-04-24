class Symbol
  unless instance_methods.include? :to_proc
    def to_proc
      Proc.new { |obj, *args| obj.send(self, *args) }
    end
  end
end

module Rack
  class Probe
    
    gem 'ruby-dtrace', '>= 0.2.7'
    require 'dtrace/provider'
        
    def initialize( app, opts = {} )
      @R = Dtrace::Provider.create :ruby, :rack
      @P = Object.new
      @P.get    = p.probe "request", "get"      # GET request
      @P.post   = p.probe "request", "post"     # POST request
      @P.put    = p.probe "request", "put"      # PUT request
      @P.delete = p.probe "request", "delete"   # DELETE request
      @P.ip     = p.probe "request", "ip",  :string     # IP of the requester
      @P.path   = p.probe "request", "path",  :string   # Path visited 
      @P.referrer = p.probe "request", "referer", :string # Referer
      @P.xhr    = p.probe "request", "xhr"                # AJAX request

      @P.request_start = p.probe "request", "request_start"   # Start of a request
      @P.request_finish = p.probe "request", "request_finish" # End of a request

      @app = app
    end

    def call( env )
      @R.request_start.fire
      request = Rack::Request.new env
      @R.get.fire  if request.get?
      @R.post.fire if request.post?
      @R.put.fire  if request.put?
      @R.delete.fire  if request.delete?
      @R.xhr.fire     if request.xhr?
      @R.path.fire(request.path)
      @R.ip.fire(request.ip)
      @R.referer.fire(request.referer)
      response = @app.call(env)
      @R.request_finish.fire
      response
    end

  end
end
