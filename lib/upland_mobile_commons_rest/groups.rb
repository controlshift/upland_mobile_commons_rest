module UplandMobileCommonsRest
  class Groups < Base

    def base_path
      'groups'
    end

    def list(page: nil, limit: nil)
      params = []

      if page
        params << "page=#{url_escape(page)}"
      end

      if limit
        params << "limit=#{url_escape(limit)}"
      end

      request_path = base_path
      if params.any?
        request_path += "?#{params.join('&')}"
      end

      resp = client.get_request(request_path)
      resp.body['response']['groups']['group']
    end

    def create(name)
      client.get_request("create_group?name=#{url_escape(name)}")
    end

    def add_member(group_id, phone_numbers)
      phone_number_argument = if phone_numbers.is_a?(Array)
                                phone_numbers.join(',')
                              else
                                phone_numbers
                              end

      client.get_request("add_group_member?group_id=#{url_escape(group_id)}&phone_number=#{url_escape(phone_number_argument)}")
    end
  end
end
