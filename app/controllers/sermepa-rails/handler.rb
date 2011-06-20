class SermepaRails::Handler < ActionController::Base
  def handler
    if request.post?
      a = params
      a.delete("action")
      a.delete("controller")
      Cyberpac::Response.create a
      head :ok
    end
  end

  def ok
    if user_signed_in? && current_user.is_client?
      redirect_to crm_url
    else
      redirect_to root_url
    end
  end

  def error
  end
end
