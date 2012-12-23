class RequestMailer < ActionMailer::Base
  default from: "site@kingarturius.ru"

  def request_email(request = {})
    @request = request
    mail :to => "requests@kingarturius.ru", :subject => @request.request_type
  end
end
