class MatchMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.match_mailer.singlesMatch.subject
  #
  def matchEmail(opponent, match, challenger)
    @user = opponent
    @match = match
    @challenger = challenger

    mail to: opponent.email, subject: "Game Set Play Match Challenge!"

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.match_mailer.doublesMatch.subject
  #
  def declineEmail(creator, match)
    @user = creator
    @match = match

    mail to: creator.email, subject: "Your challenge has been declined!"
  end

  # Sends an email for singles' score validation.
  def validationEmail(player, match)
    @user = player
    @match = match
    
    mail to: player.email, subject: "Please validate score update."
  end

  # Sends an email in the event of an invalid score.
  def invalidScoreEmail(player, match)
    @user = player
    @match = match
    
    mail to: player.email, subject: "Scores deemed invalid!"
  end
end
