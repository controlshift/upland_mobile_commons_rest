module UplandMobileCommonsRest
  class Base < Vertebrae::Model
    def url_escape(string)
      CGI.escape(string.to_s)
    end

  end
end
