# This controller is going to have a lot of one-off queries. If they do need
# to be used elsewhere, remember to make them into model scopes.

class ModController < ApplicationController
  include IntervalHelper

  before_action :require_logged_in_moderator, :default_periods

  def index
    # setup for rendering moderations/index from mod/index:
    @mod_dashboard_render = true
    @page = @pages = 0

    @moderations = Moderation.all
      .eager_load(:moderator, :story, :comment, :tag, :user)
      .where("moderator_user_id != ? or moderator_user_id is null", @user.id)
      .where('moderations.created_at >= (NOW() - INTERVAL 1 MONTH)')
      .order('moderations.id desc')
  end

  def flagged
    @stories = period(Story.base
      .includes(:user, :suggested_titles, :suggested_taggings, :tags)
      .where("downvotes > 1")
      .order("stories.id DESC"))
  end

  def downvoted
    @comments = period(Comment
      .eager_load(:user, :hat, :story => :user, :votes => :user)
      .where("(select count(*) from votes where
                votes.comment_id = comments.id and
                vote < 0 and
                votes.reason != 'M') > 2") # Me-Too comments rarely need attention
      .order("comments.id DESC"))
  end

private

  def default_periods
    @periods = %w{1d 2d 3d 1w 1m}
  end

  def period(query)
    length = time_interval(params[:period])
    query.where("#{query.model.table_name}.created_at >=
      (NOW() - INTERVAL #{length[:dur]} #{length[:intv].upcase})")
  end
end
