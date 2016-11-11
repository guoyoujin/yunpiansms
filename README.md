# Yunpiansms

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/yunpiansms`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yunpiansms'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yunpiansms

## Usage
The main method
```ruby
def send_to(content, mobiles = nil)
  http.post(Yunpiansms::SmsResources::SEND_URL,params_data(content, mobiles))
end

def tpl_send_to(content, mobiles = nil, tpl_id = nil, tpl_value=nil)
  http.post(Yunpiansms::SmsResources::TPL_SEND_URL,params_data_tpl(content, mobiles, tpl_id,tpl_value))
end

def get_record(options={})
  http.get(Yunpiansms::SmsResources::GET_URL,format_content(options))
end
```
Usage
```ruby
@yunpiansms_service = Yunpiansms::Service.config do |s|
  s.apikey             = ""        # apikey
  s.connection_adapter = :net_http # default
end

content = {mobile: "1367777777,1367777777",text: "123",uid: "15279"}
result = @yunpiansms_service.send_to(content)

content = {text: "123",uid: "15279"}
result = @yunpiansms_service.send_to(content,["1367777777","1367777777"])
result = @yunpiansms_service.send_to(content,"1367777777,1367777777")

content = {mobile: "1367777777,1367777777",tpl_value: {key:"1245",key1:"23"},uid: "15279",tpl_id:1}
result = @yunpiansms_service.tpl_send_to(content)

result = @yunpiansms_service.get_record({start_time: Time.now,end_time:Time.now,page_num:1,page_size:100,mobile:"15279058466"})
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/yunpiansms.

