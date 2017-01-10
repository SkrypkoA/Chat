class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :delete_relation, :create_relation]
  before_action :set_new_category, only: [:create]

  def index
    @categories = Category.all.preload(:users)
  end

  def show
    @pictures = @category.pictures
    @picture = @category.pictures.build
  end

  def create
    Category.create!(set_new_category)
    redirect_to :back
  end

  def delete_relation
    current_user.unfollow_category!(@category)
    redirect_to :back
  end

  def create_relation
    current_user.follow_category!(@category)
    redirect_to :back
  end

  private
  def set_category
    @category = Category.find_by(name: params[:id])
  end

  def set_new_category
    params.require(:category).permit(:name,:description)
  end
end