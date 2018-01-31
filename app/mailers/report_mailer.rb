# frozen_string_literal: true

class ReportMailer < ActionMailer::Base
  def news
    User.active.subscribe_on_emails.each do |user|
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
         subject: t('pictures_upload_report'),
         from: 'amazing2gallery@gmail.com') do |format|
      format.html do
        render 'report_mailer/error_report',
               locals:
               {
                 main_report: main_report, errors_report: errors_report
               }
      end
      format.text { render plain: 'Render text' }
    end
  end
end
