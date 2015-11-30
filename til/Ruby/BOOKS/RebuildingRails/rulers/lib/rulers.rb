require "rulers/version"
require "rulers/routing"
require "rulers/array"
require "rulers/util"

module Rulers
  class Application
    def call(env)
      # avoid error on favicon...
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'Content-Type' => 'text/html'}, []]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)
      text = controller.send(act)
      [301, {"Location" => "http://google.fr"},[]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end
    def env
      @env
    end
  end
end
