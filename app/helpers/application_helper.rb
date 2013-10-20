module ApplicationHelper
  
  def javascript_cdn_tag(file, version, minify = true)
    cdn = '//cdnjs.cloudflare.com/ajax/libs'
    javascript_include_tag [cdn, file, version, [file, (minify ? 'min' : nil), 'js'].compact.join('.')].join('/')
  end
  
end

