module ApplicationHelper
  
  def javascript_cdn_tag(file, version, minify = true)
    cdn = '//cdnjs.cloudflare.com/ajax/libs'
    javascript_include_tag [cdn, file, version, [file, (minify ? 'min' : nil), 'js'].compact.join('.')].join('/')
  end
  
  def flash_message
    [:notice, :error, :alert, :warning, :info, :success].each do |key|
      return content_tag(:div, flash[key], class: "flash #{key}") if flash[key]
    end unless flash.empty?
  end
  
end

