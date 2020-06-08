module UplandMobileCommonsRest
  class Campaigns < Vertebrae::Model

    def base_path
      'campaigns'
    end

    def list
      resp = client.get_request(base_path)
      resp.body['response']['campaigns']['campaign']
    end
  end
end
