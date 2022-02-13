class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Evgen',
        username: 'Evgenno',
        avatar_url: 'https://st4.depositphotos.com/20523700/25919/i/1600/depositphotos_259190824-stock-photo-illustration-avatar-icon.jpg'
      ),
      User.new(
        id: 2,
        name: 'Dmitriy',
        username: 'Dmitriyno',
        avatar_url: 'https://media.istockphoto.com/vectors/customer-service-icon-vector-male-data-support-person-profile-avatar-vector-id1162692122'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Evgen',
      username: 'Evgenno',
      avatar_url: 'https://sin5.org/images/faces/1.jpg'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('12.02.2022')),
      Question.new(text: 'В чём смысл жизни?', created_at: Date.parse('12.02.2022'))
    ]

    @new_question = Question.new
  end
end
