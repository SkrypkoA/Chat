class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :delete_relation, :create_relation]
  before_action :set_new_category, only: [:create]

  def index
    @categories = Category.all.preload(:users)#.order("name")
    #@categories = Category.left_joins(:user_categories).select("categories.*, user_categories.id AS relation_id").where(user_categories: {user: current_user})
    #@categories = Category.joins("LEFT JOIN user_categories
    #ON categories.id = user_categories.category_id
    #AND user_categories.user_id = ?",current_user.id).select("categories.*, user_categories.id
    #AS relation_id")
  end

  def show
    #@category = Category.find(params[:id])
    # @category = Category.find(params[:id])
    @pictures = @category.pictures#.page(params[:page])
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
