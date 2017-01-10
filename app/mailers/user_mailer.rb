class UserMailer < ApplicationMailer
  default from: 'ixsiwat@gmail.com'

  def add_picture_notification(user, picture)
    @user = user
    @url = "http://localhost:3000/"
    @picture = picture

    attachments.inline['image.jpg'] = picture.location.read

    mail(to: @user.email, subject: 'add new tits to category: ' +
        picture.category.name + ', ' + picture.description)

  end
end
