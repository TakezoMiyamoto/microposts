class StaticPagesController < ApplicationController
  def home
    
    if logged_in?
    # ログインしている場合は、新しいMicropostクラスのインスタンスをuser_idを紐付けた状態で初期化
    @micropost = current_user.microposts.build 
    @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
  
end

# current_user.microposts.buildは、Micropost.new(user_id: current_user.id)と同じです。
# 前者の方はcurrent_userのhas_many :micropostsで生成されるbuildメソッドを使用していて、
# 確実にuser_idが紐付いたデータを作成できるのでこちらを使用するようにしましょう。