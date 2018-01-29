# frozen_string_literal: true

class ReportMailer < ActionMailer::Base
  def news
    User.active.find_each do |user|
      mail(to: user.email,
           subject: t('mail_news'),
           from: 'amazing2gallery@gmail.com') do |format|
        format.html { render 'report_mailer/news', locals: { user: user } }
        format.text { render plain: 'Render text' }
      end
    end
  end

  def report_about_parsing(email, main_report, errors_report)
    mail(to: email,
         subject: t('error_report'),
         from: 'amazing2gallery@gmail.com') do |format|
      format.html { render 'report_mailer/error_report', locals: { main_report: main_report, errors_report: errors_report } }
      format.text { render plain: 'Render text' }
    end
  end
end
