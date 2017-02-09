class MyJobJob < ApplicationJob
  #include SuckerPunch::Job
  queue_as :default

  before_enqueue do |job|
    puts "mememe"
  end

  after_perform do |job|
    puts "bebebe"
  end

  def perform(text)
    puts text
    Picture.first.comments.create(user: User.first, content: text)
  end
end
