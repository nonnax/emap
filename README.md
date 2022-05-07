EMap: GET /url to erb template mapper

```ruby
EMap.define do

  # a symbol is maps an erb file found in `public/` dir
  erb '/', :index, time: Time.now, layout: :'views/layout'

  erb '/hi', 'hello, there!'

end
```
