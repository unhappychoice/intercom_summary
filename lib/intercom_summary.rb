require 'intercom_summary/version'
require 'intercom'
require 'time'

module IntercomSummary
  class CLI
    SECONDS_OF_DAY = (60 * 60 * 24).freeze

    def self.start
      users = []

      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'], api_key: ENV['INTERCOM_APP_KEY'])
      intercom.users.scroll.each { |user| users.push user }

      monthly_active_users = users.select { |user| user.last_request_at.to_i + SECONDS_OF_DAY * 30 > Time.now.to_i }
      weekly_active_users = users.select { |user| user.last_request_at.to_i + SECONDS_OF_DAY * 7 > Time.now.to_i }
      daily_active_users = users.select { |user| user.last_request_at.to_i + SECONDS_OF_DAY * 1 > Time.now.to_i }

      monthly_signed_up_users = users.select { |user| user.signed_up_at.to_i < Time.now.to_i && user.signed_up_at.to_i + SECONDS_OF_DAY * 30 > Time.now.to_i }
      weekly_signed_up_users = users.select { |user| user.signed_up_at.to_i < Time.now.to_i && user.signed_up_at.to_i + SECONDS_OF_DAY * 7 > Time.now.to_i }
      daily_signed_up_users = users.select { |user| user.signed_up_at.to_i < Time.now.to_i && user.signed_up_at.to_i + SECONDS_OF_DAY * 1 > Time.now.to_i }


      puts "Monthly active users\t#{monthly_active_users.size}"
      puts "Weekly active users\t#{weekly_active_users.size}"
      puts "Daily active users\t#{daily_active_users.size}"

      puts "Monthly signed up users\t#{monthly_signed_up_users.size}"
      puts "Weekly signed up users\t#{weekly_signed_up_users.size}"
      puts "Daily signed up users\t#{daily_signed_up_users.size}"
    end
  end
end
