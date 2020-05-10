class CategoriesController < ApplicationController
  before_action :set_parents

  def index
  end

  def parent_list
  end
  
  def child_list
  end

  def grandchild_list
  end

  private
  def set_parents
    @parents = Category.all.order("id ASC").limit(13)
  end
end
