get '/' do
    protected!
    erb :index
end

get '/login' do
  erb :login
end

get '/logout' do
  session["access_token"] = nil
  redirect to("/")
end

post '/login' do
  
  if params[:username] == "username" && params[:password] == "password"
    
    headers = {
      exp: Time.now.to_i + 30 #expire in 30 seconds
    }

    @token = JWT.encode({user_id: 123456}, settings.signing_key, "RS256", headers)
    
    session["access_token"] = @token
    redirect to("/")
  else
    @message = "Username/Password failed."
    erb :login
  end
end