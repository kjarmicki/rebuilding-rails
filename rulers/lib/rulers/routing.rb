module Rulers
  class Application
    def get_controller_and_action(env)
      _, cont, action, after = env["PATH_INFO"].split('/', 4)
      cont = cont.capitalize
      cont = 'Home' if cont == ''
      cont += 'Controller'
      action = 'index' if !action

      # Object.const_get looks up a reference to const by string name
      [Object.const_get(cont), action]
    end
  end
end
