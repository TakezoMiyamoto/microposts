module SessionsHelper
    def current_user
        @current_user ||= User.find_by(id: session[:user_id]) #||=は左の値がfalseかnilの場合に右の値の代入を行います
        #||=で代入を行っているので、左側の@current_userに値が入っている場合は、右側のUser.find_byで始まる処理は実行されません。
        #⇨すなわち、ログインしているユーザーを毎回DBに取りに行かなくてすみます。
    end
    
    # 渡されたユーザーでログインする
    def log_in(user)
       session[:user_id] = user.id 
    end
   
    def logged_in?
        !!current_user # !!は、右側に続く値が存在する場合はtrueを、nilの場合はfalseを返します
    end
    
    def store_location
        # リクエストがGETの場合は、session[:forwarding_url]にリクエストのURLを代入
        # ログインが必要なページにアクセスしようとした際に、ページのURLを一旦保存しておき、
        # ⇨ログイン画面に遷移してログイン後に再び保存したURLにアクセスする場合にこのメソッドを使用します
        session[:forwarding_url] = request.url if request.get?
    end
end