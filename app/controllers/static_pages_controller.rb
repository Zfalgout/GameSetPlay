class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.where("p2Active = ? AND p3Active = ? AND p4Active = ?", 1, 1, 1).paginate(page: params[:page]).order(time: :desc)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
