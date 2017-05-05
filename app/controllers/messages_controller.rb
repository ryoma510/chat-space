class MessagesController < ApplicationController
  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      respond_to do |format|
        # これはビュー全体を返すためのやつ
        format.html { redirect_to group_path(@message.group_id) }
        # これは全体ビューに差し込むビューを返してくる
        format.json { render json: message_for_js(@message) }
      end
    else
      redirect_to group_path(message_params[:group_id]), alert: 'メッセージか画像が入力されていません'
    end
  end

  private

  def message_for_js(message)
    hash = { user_name: message.user.name, created_at: message.created_at.strftime('%Y年%m月%d日 %H時%M分') }
    if message.content.present? && message.image.present?
      return hash.merge({ content: message.content, image: message.image.to_s })
    elsif message.content.present?
      return hash.merge({ content: message.content })
    else
      return hash.merge({ image: message.image.to_s })
    end
  end

  def message_params
    params.require(:message).permit(:content, :group_id, :image)
  end
end
