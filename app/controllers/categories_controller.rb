class CategoriesController < ApplicationController

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def category1
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def category2
    @parents = Category.all.order("id ASC").limit(13)
  end

  def category3
    @parents = Category.all.order("id ASC").limit(13)
  end

end
