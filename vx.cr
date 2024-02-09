FEATURED_IMAGE = {
  "url"         => "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Raspberries05.jpg/1200px-Raspberries05.jpg?20060301080442",
  "author"      => "Fir0002",
  "license"     => "CC BY-NC",
  "license_url" => "https://creativecommons.org/licenses/by-nc/2.0/",
}

def build_site(fn, tn)
  site_config = {
    "url"     => "https://valixym.net",
    "contact" => "v@valixym.net",
    "repo"    => "https://github.com/valixym/valixym.net",
    "title"   => "VALIXYM.NET",
    "yao"     => fn,
    "tagline" => "\"In Heaven, everything is fine\"",
  }

  content = File.read_lines("content/#{fn}")[2..-1].join("\n")
  page_title = File.read_lines("content/#{fn}")[0]

  template = File.read("templates/#{tn}.html")
  xout = template.gsub("{% PAGE_CONTENT %}", content)
  xout = xout.gsub("{% PAGE_TITLE %}", page_title)

  site_config.each do |cfg|
    xout = xout.gsub("{% site_#{cfg[0]} %}", cfg[1])
  end

  FEATURED_IMAGE.each do |cfg|
    xout = xout.gsub("{% fm_#{cfg[0]} %}", cfg[1])
  end

  File.write("dist/#{fn}", xout)
end

Dir.new("content").entries.each do |cf|
  if cf == "Layer14"
    break
  end
  build_site(cf, "index")
  puts cf
end
