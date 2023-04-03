module ApplicationHelper
  def render_if(cond, obj)
    if cond
      render(obj)
    end
  end
end
