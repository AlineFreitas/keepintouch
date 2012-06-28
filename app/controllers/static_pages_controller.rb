class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @partner = current_user.partners.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
end
