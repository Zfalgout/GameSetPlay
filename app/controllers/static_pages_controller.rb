class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_items = current_user.feed.where("p2Active = ? AND p3Active = ? AND p4Active = ?", 1, 1, 1).where(time: 10.years.ago..1.month.from_now).paginate(page: params[:page]).order(time: :desc)
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
