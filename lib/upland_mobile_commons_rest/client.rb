module UplandMobileCommonsRest
  class Client < Vertebrae::API
    attr_accessor :username, :password

    def initialize(options={})
      self.username = options[:username]
      self.password = options[:password]
    end
  end
end
