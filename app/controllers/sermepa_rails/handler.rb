class SermepaRails::Handler < ActionController::Base
  def notify
    if request.post?
      a = params
      a.delete("action")
      a.delete("controller")
      Sermepa::Rails::Response.create a
      head :ok
    end
  end
end
