fn = ARGV[0]
tn = ARGV[1]

SITE_CONFIG = {
  "url"     => "https://valixym.net",
  "contact" => "v@valixym.net",
  "repo"    => "https://github.com/valixym/valixym.net",
  "title"   => "VALIXYM",
  "yao"     => ARGV[0],
}

# FEATURED_IMAGES = {
#   "url1" => "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Raspberries05.jpg/1200px-Raspberries05.jpg?20060301080442",
#   "url2" => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Jonos-table-photo_edit.jpg/1200px-Jonos-table-photo_edit.jpg?20240104074741",
# }

content = File.read_lines("content/#{fn}.html")[2..-1].join("\n")
page_title = File.read_lines("content/#{fn}.html")[0]

template = File.read("templates/#{tn}.html")
xout = template.gsub("{% PAGE_CONTENT %}", content)
xout = xout.gsub("{% PAGE_TITLE %}", page_title)

SITE_CONFIG.each do |cfg|
  xout = xout.gsub("{% site_#{cfg[0]} %}", cfg[1])
end

FEATURED_IMAGES.each do |cfg|
  xout = xout.gsub("{% fm_#{cfg[0]} %}", cfg[1])
end

File.write("dist/#{fn}.html", xout)
