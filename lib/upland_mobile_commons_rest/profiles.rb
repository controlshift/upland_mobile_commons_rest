module UplandMobileCommonsRest
  class Profiles < Base

    def update(params)
      client.post_request('profile_update', params)
    end
  end
end