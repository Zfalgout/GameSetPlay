class MatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.match_mailer.singlesMatch.subject
  #
  def singlesMatch
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.match_mailer.doublesMatch.subject
  #
  def doublesMatch
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
