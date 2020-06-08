module UplandMobileCommonsRest
  class Groups < Base

    def base_path
      'groups'
    end

    def list
      resp = client.get_request(base_path)
      resp.body['response']['groups']['group']
    end

    def create(name)
      client.get_request("create_group?name=#{url_escape(name)}")
    end
  end
end
