# RailsRoutingAnalytics

Compare defined routes and request logs, and generate report about routing

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_routing_analytics', group: :development
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_routing_analytics

## Usage

### Rake tasks

#### Generete used and unused routes csv file

    $ SRC_PATH=./requests.csv bin/rails rails_routing_analytics:generate_report

if it use grape, it should set `ENV[GRAPE_API_CLASS]`

    $ SRC_PATH=./requests.csv GRAPE_API_CLASS=API bin/rails rails_routing_analytics:generate_report

#### Generate all routes csv file

    $ bin/rails rails_routing_analytics:routes:all

if it use grape, it should set `ENV[GRAPE_API_CLASS]`

    $ GRAPE_API_CLASS=API bin/rails rails_routing_analytics:routes:all

#### Generate rails routes csv file

    $ bin/rails rails_routing_analytics:routes:rails

#### Generate grape routes csv file

    $ GRAPE_API_CLASS=API bin/rails rails_routing_analytics:routes:grape

#### Generate used routes csv file

    $ SRC_PATH=./requests.csv bin/rails rails_routing_analytics:routes:used

if it use grape, it should set `ENV[GRAPE_API_CLASS]`

    $ SRC_PATH=./requests.csv GRAPE_API_CLASS=API bin/rails rails_routing_analytics:routes:used

#### Generate unused routes csv file

    $ SRC_PATH=./requests.csv bin/rails rails_routing_analytics:routes:unused

if it use grape, it should set `ENV[GRAPE_API_CLASS]`

    $ SRC_PATH=./requests.csv GRAPE_API_CLASS=API bin/rails rails_routing_analytics:routes:unused

### Manually in console

```
$ bin/rails console
[1] pry(main)> RailsRoutingAnalytics.config.src_path = './requests.csv'
[2] pry(main)> RailsRoutingAnalytics.config.grape_api_class = MyAPI # if you mount grape at rails
[3] pry(main)> RailsRoutingAnalytics.generate_report
I, [2019-09-10T22:25:32.740719 #57212]  INFO -- : Generate: used.csv (283.000921 sec)
I, [2019-09-10T22:25:32.787153 #57212]  INFO -- : Generate: unused.csv (0.046148 sec)
```

### Required csv format

You need to prepare csv format like this:

```csv
method,path
GET,/
POST,/articles
...
```

## License

[MIT License](https://opensource.org/licenses/MIT)
