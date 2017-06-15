module Rocket
  class LogHandler
    include HTTP::Handler

    def initialize(@io : IO = STDOUT)
    end

    def call(context)
      time = Time.now
      call_next(context)

      @io.puts "#{context.request.method} #{context.request.resource} - #{context.response.status_code} at #{time}\n\n"
    rescue e
      @io.puts  "#{context.request.method} #{context.request.resource} - Exception at #{time} => \n\n"
      e.inspect_with_backtrace(@io)
      @io.puts "\n"
      raise e
    end
  end
end
