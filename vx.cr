FEATURED_IMAGE = {
  "url"         => "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/RussianAbortionPoster.jpg/773px-RussianAbortionPoster.jpg?20180621140613",
  "author"      => "the National Library of Medicine",
  "license"     => "Public Domain",
  "license_url" => "https://en.wikipedia.org/wiki/Public_domain",
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

  content = File.read_lines("content/main/#{fn}")[2..-1].join("\n")
  page_title = File.read_lines("content/main/#{fn}")[0]

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

Dir.new("content/main").entries.each do |cf|
  if cf == "."
    break
  else
    puts cf
    build_site(cf, "index")
  end
end
