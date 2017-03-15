require 'intercom_summary/version'
require 'intercom'
require 'time'

module IntercomSummary
  class CLI
    def self.start
      intercom = Intercom::Client.new(app_id: ENV['INTERCOM_APP_ID'], api_key: ENV['INTERCOM_APP_KEY'])

      # User summaries
      users = []
      intercom.users.scroll.each { |user| users.push user }

      puts "Monthly active users\t\t#{filter_by_last_request_at(users, 30).size}"
      puts "Weekly active users\t\t#{filter_by_last_request_at(users, 7).size}"
      puts "Daily active users\t\t#{filter_by_last_request_at(users, 1).size}"

      puts "Monthly signed up users\t\t#{filter_by_signed_up_at(users, 30).size}"
      puts "Weekly signed up users\t\t#{filter_by_signed_up_at(users, 7).size}"
      puts "Daily signed up users\t\t#{filter_by_signed_up_at(users, 1).size}"

      # Company summaries
      companies = []
      intercom.companies.scroll.each { |company| companies.push company }

      puts "Monthly active companies\t#{filter_by_last_request_at(companies, 30).size}"
      puts "Weekly active companies\t\t#{filter_by_last_request_at(companies, 7).size}"
      puts "Daily active companies\t\t#{filter_by_last_request_at(companies, 1).size}"

      puts "Monthly signed up companies\t#{filter_by_created_at(companies, 30).size}"
      puts "Weekly signed up companies\t#{filter_by_created_at(companies, 7).size}"
      puts "Daily signed up companies\t#{filter_by_created_at(companies, 1).size}"
    end

    def self.filter_by_last_request_at(list, days)
      list.select { |e| is_date_before_days(e.last_request_at, days) }
    end

    def self.filter_by_signed_up_at(list, days)
      list.select { |e| is_date_before_days(e.signed_up_at, days) }
    end

    def self.filter_by_created_at(list, days)
      list.select { |e| is_date_before_days(e.created_at, days) }
    end

    def self.is_date_before_days(date, days)
      seconds_of_day = (60 * 60 * 24).freeze
      date && date.to_i < Time.now.to_i && date.to_i + seconds_of_day * days > Time.now.to_i
    end
  end
end
