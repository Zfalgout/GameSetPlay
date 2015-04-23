class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page]).order(time: :asc)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
