# ScaleRb

*WARNING: UNDER DEVELOPMENT*

## Demo

### Docker

* Install and run Docker

* Build and run Docker container
```bash
docker build --platform linux/x86_64 -f ./Dockerfile --tag scale-rb:v0.2.2 ./
docker run --platform linux/x86_64 \
    --network host \
    -it -d --hostname scale-rb --name scale-rb --volume ./:/scale-rb:rw scale-rb:v0.2.2
```
Enter shell of Docker container
```bash
docker exec -it scale-rb /bin/bash
```

* Build and run Ruby program in Docker container
```bash
bundle install
ruby example/main.rb
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scale_rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install scale_rb

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wuminzhe/scale_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/wuminzhe/scale_rb/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ScaleRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/scale_rb/blob/master/CODE_OF_CONDUCT.md).
