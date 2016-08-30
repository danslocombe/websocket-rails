module WebsocketRails

  class SpecHelperEvent < Event

    attr_reader :dispatcher, :triggered

    alias :triggered? :triggered

    def initialize(event_name,options={})
      super(event_name, options)
      @triggered = false
      @dispatcher =  Dispatcher.new(nil)

      
      if (options[:data] && options[:data][:_socket_id])
        @socket_id = options[:data][:_socket_id]
      else
        @socket_id = Faker::Number.number(4)
      end
    end

    def trigger
      @triggered = true
    end

    def dispatch
      @dispatcher.dispatch(self)
      return self
    end

    def connection
      OpenStruct.new(:id => @socket_id)
    end

  end

end

def create_event(name, data)
  WebsocketRails::SpecHelperEvent.new(name, {data: data})
end
