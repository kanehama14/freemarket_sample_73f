class CategoriesController < ApplicationController

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def parentlist
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def childlist
    @parents = Category.all.order("id ASC").limit(13)
  end

  def grandchildlist
    @parents = Category.all.order("id ASC").limit(13)
  end

end
