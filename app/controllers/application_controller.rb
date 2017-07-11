class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
    if session[:user_id]
      @user = User.find_by(uid: session[:user_id])
      render 'layouts/logged_in.html'
    else
      render 'layouts/login.html'
    end
  end

  def search_by_user
    user = User.find_by(uid: session[:user_id])
    posts = user.client.user_timeline(params[:handle])
    render json: posts
  rescue Twitter::Error::NotFound
    head 404
  end

  def search_by_hashtag
    user = User.find_by(uid: session[:user_id])
    posts = user.client.search("##{params[:hashtag]}")
    render json: posts
  end

  def search_by_date
    user = User.find_by(uid: session[:user_id])
    key = params[:key].split('-')
    puts key
    posts = user.client.search("#{key[0]}", { since:"#{key[3]}-#{key[1]}-#{key[2]}", count: 5 })
    posts = posts.select { |post| post.created_at > Time.new(key[3],key[1],key[2],key[4],key[5],key[6]) }
    render json: posts
  end

  # Filters out posts created before a certain time
  def filter_posts(posts, time)
    posts.select { |post| post.created_at > time }
  end
end
