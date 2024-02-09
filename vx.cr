fn = ARGV[0]
tn = ARGV[1]

SITE_CONFIG = {
  "url"     => "https://valixym.net",
  "contact" => "v@valixym.net",
  "repo"    => "https://github.com/valixym/valixym.net",
  "title"   => "VALIXYM",
  "yao"     => ARGV[0],
}

FEATURED_IMAGE = {
  "url"         => "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Raspberries05.jpg/1200px-Raspberries05.jpg?20060301080442",
  "author"      => "Fir0002",
  "license"     => "CC BY-NC",
  "license_url" => "https://creativecommons.org/licenses/by-nc/2.0/",
}

content = File.read_lines("content/#{fn}.html")[2..-1].join("\n")
page_title = File.read_lines("content/#{fn}.html")[0]

template = File.read("templates/#{tn}.html")
xout = template.gsub("{% PAGE_CONTENT %}", content)
xout = xout.gsub("{% PAGE_TITLE %}", page_title)

SITE_CONFIG.each do |cfg|
  xout = xout.gsub("{% site_#{cfg[0]} %}", cfg[1])
end

FEATURED_IMAGE.each do |cfg|
  xout = xout.gsub("{% fm_#{cfg[0]} %}", cfg[1])
end

File.write("dist/#{fn}.html", xout)
