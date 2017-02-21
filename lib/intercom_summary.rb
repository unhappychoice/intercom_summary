require 'intercom_summary/version'
require 'intercom'
require 'time'

module IntercomSummary
  class CLI
    SECONDS_OF_DAY = (60 * 60 * 24).freeze

    def self.start
      users = []

      puts 'Loading users from intercom...'
      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'], api_key: ENV['INTERCOM_APP_KEY'])
      intercom.users.scroll.each { |user| users.push user }

      monthly_active_users = users.select { |user| user.last_request_at.to_i + SECONDS_OF_DAY * 30 > Time.now.to_i }
      weekly_active_users = users.select { |user| user.last_request_at.to_i + SECONDS_OF_DAY * 7 > Time.now.to_i }
      daily_active_users = users.select { |user| user.last_request_at.to_i + SECONDS_OF_DAY * 1 > Time.now.to_i }

      puts '====================================='
      puts 'Active Users'
      puts '====================================='
      puts "monthly: #{monthly_active_users.size}"
      puts "weekly: #{weekly_active_users.size}"
      puts "daily: #{daily_active_users.size}"

      puts ''
    end
  end
end