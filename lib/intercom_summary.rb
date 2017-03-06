require 'intercom_summary/version'
require 'intercom'
require 'time'

module IntercomSummary
  class CLI
    def self.start
      users = []

      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'], api_key: ENV['INTERCOM_APP_KEY'])
      intercom.users.scroll.each { |user| users.push user }

      monthly_active_users = users.select { |user| is_date_before_days(user.last_request_at, 30) }
      weekly_active_users = users.select { |user| is_date_before_days(user.last_request_at, 7) }
      daily_active_users = users.select { |user| is_date_before_days(user.last_request_at, 1) }

      monthly_signed_up_users = users.select { |user| is_date_before_days(user.signed_up_at, 30) }
      weekly_signed_up_users = users.select { |user| is_date_before_days(user.signed_up_at, 7) }
      daily_signed_up_users = users.select { |user| is_date_before_days(user.signed_up_at, 1) }

      puts "Monthly active users\t#{monthly_active_users.size}"
      puts "Weekly active users\t#{weekly_active_users.size}"
      puts "Daily active users\t#{daily_active_users.size}"

      puts "Monthly signed up users\t#{monthly_signed_up_users.size}"
      puts "Weekly signed up users\t#{weekly_signed_up_users.size}"
      puts "Daily signed up users\t#{daily_signed_up_users.size}"
    end

    def self.is_date_before_days(date, days)
      seconds_of_day = (60 * 60 * 24).freeze
      date && date.to_i < Time.now.to_i && date.to_i + seconds_of_day * days > Time.now.to_i
    end
  end
end
