class Public::EventCommentsController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    comment = current_user.event_comments.new(event_comment_params)
    comment.event = event
    if comment.save
      event.create_notification_comment!(current_user, comment.id)
      redirect_to event_path(event.id)
    else
      render 'events/show'
    end
  end
  
  private
  def event_comment_params
    params.require(:event_comment).permit(:comment)
  end
end
