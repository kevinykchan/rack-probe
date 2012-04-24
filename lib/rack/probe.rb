class Symbol
  unless instance_methods.include? :to_proc
    def to_proc
      Proc.new { |obj, *args| obj.send(self, *args) }
    end
  end
end

module Rack
  class Probe
    gem 'ruby-usdt'

    def initialize( app, opts = {} )
      @pv = USDT::Provider.create :ruby, :rack

      @P = {}
      @P[:get]    = @pv.probe :request, :get      # GET request
      @P[:post]   = @pv.probe :request, :post     # POST request
      @P[:put]    = @pv.probe :request, :put      # PUT request
      @P[:delete] = @pv.probe :request, :delete   # DELETE request
      @P[:ip]     = @pv.probe :request, :ip, :string   # IP of the requester
      @P[:path]   = @pv.probe :request, :path, :string # Path visited
      @P[:referrer] = @pv.probe :request, :referer, :string # Referer
      @P[:xhr]    = @pv.probe :request, :xhr           # AJAX request

      @P[:request_start] = @pv.probe :request, :request_start   # Start of a request
      @P[:request_finish] = @pv.probe :request, :request_finish # End of a request

      @app = app
    end

    def call( env )
      @P[:request_start].fire
      request = Rack::Request.new env
      @P[:get].fire  if request.get?
      @P[:post].fire if request.post?
      @P[:put].fire  if request.put?
      @P[:delete].fire  if request.delete?
      @P[:xhr].fire     if request.xhr?
      @P[:path].fire(request.path)
      @P[:ip].fire(request.ip)
      @P[:referer].fire(request.referer)
      response = @app.call(env)
      @P[:request_finish].fire
      response
    end

  end
end
