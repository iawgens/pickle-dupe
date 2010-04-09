# controllers
class DefaultController < ActionController::Base
  def index
    render :text => "index: I was invoked with #{request.path}"
  end
  
  def show
    render :text => "show: I was invoked with #{request.path}"
  end
  
  def new
    render :text => "new: I was invoked with #{request.path}"
  end
  
  def edit
    render :text => "edit: I was invoked with #{request.path}"
  end
end