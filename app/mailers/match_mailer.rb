class MatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.match_mailer.singlesMatch.subject
  #
  def matchEmail(opponent)
    #@user = opponent

    mail to: opponent.email, subject: "Game Set Play Match Challenge!"

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.match_mailer.doublesMatch.subject
  #
  def doublesMatch(player2, player3, player4)


    mail to: "to@example.org"
  end
end
