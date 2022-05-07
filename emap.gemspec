Gem::Specification.new do |s|
  s.name = 'emap'
  s.version = '0.0.1'
  s.date = '2022-05-07'
  s.summary = "GET /url to ERB template mapper"
  s.authors = ["xxanon"]
  s.email = "ironald@gmail.com"
  s.files = `git ls-files`.split("\n") - %w[bin misc]
  s.executables += `git ls-files bin`.split("\n").map{|e| File.basename(e)}
  s.homepage = "https://github.com/nonnax/emap.git"
  s.license = "GPL-3.0"
end
