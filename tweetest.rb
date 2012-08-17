require 'bundler/setup'
require 'twitter'
require 'innsights'

Innsights.setup do
  credentials 'app' => "tweetest-181ca6", "token" => '43b9424f1ece9edabdac3925'
  enviroment 'development'

  config do
    mode :test
  end
end

class Tweetest
  def initialize(companies={})
    @companies = companies
  end

  def fetch
    @companies.each do |company,dudes|
      puts "[#{company}]"
      dudes.each do |dude|
        puts "  #{dude}"
        tweets = Twitter.user_timeline(dude, :count => 20)
        tweets.each{|tweet| report(tweet)}
      end
    end
  end

  def report tweet
    Innsights.report('Un reporte falso').run
  end
end


companies = {'Innku' => %w(adriancuadros chinog9), '37Signals' => %w( dhh jasonfried )}
t = Tweetest.new(companies)
t.fetch
