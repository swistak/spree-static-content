class ContentController < Spree::BaseController
  skip_before_filter :instantiate_controller_and_action_names

  def show
    path = "page/#{params[:path].join("/")}"
    pid = Cache.get(path.to_url, 30) do
      page = Page.find_by_slug(params[:path])
      page && page
    end
    unless pid && (@page = Page.find_by_id(pid))
      render :file => "#{RAILS_ROOT}/public/404.html", :layout => false, :status => 404
    end
  end
  
  def cvv
    render "cvv", :layout => false
  end  
end
