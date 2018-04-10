helpers do

    def protected!
        return if authorized?
        redirect to('/login')
    end

    def extract_token
        token = request.env["access_token"]
        
        if token
            return token
        end
        token = request["access_token"]

        if token
            return token
        end
        token = session["access_token"]

        if token
            return token
        end

        return nil
    end

    def authorized?
        @token = extract_token
        begin
            payload, header = JWT.decode @token, settings.verify_key, true, { algorithm: "RS256" }
            
            @exp = header["exp"]

            if @exp.nil?
                puts "Access token doesn't have exp set"
                return false
            end

            @exp = Time.at(@exp.to_i)

            if Time.now > @exp
                puts "Access token expired"
                return false
            end

            @user_id = payload["user_id"]

        rescue JWT::DecodeError => ex
            puts "An error of type #{ex.class} happened, message is #{ex.message}"
            return false
        end
    end
end