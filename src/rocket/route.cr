module Rocket
  class Route
    property method     : String
    property path       : String
    property controller : Controller
    property action     : String

    def initialize(@method, @path, @controller, @action)
    end
  end
end
