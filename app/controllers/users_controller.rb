class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_path, alert: 'Вы уже залогинены!' if current_user.present?
    @user = User.new
  end

  def edit
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены!' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Пользователь успешно создан!'
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    reset_session
    redirect_to root_path, notice: 'Ваш аккаунт удалён! :( '
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_with_answers = @user.questions.where.not(answer: [nil, ""]).count
    @questions_without_answers = @questions.count - @questions_with_answers
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url, :color)
  end
end
