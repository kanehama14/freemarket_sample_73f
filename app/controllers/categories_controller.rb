class CategoriesController < ApplicationController

  def index
    @parents = Category.all.order("id ASC").limit(13)
  end

  def parent_list
    @parents = Category.all.order("id ASC").limit(13)
  end
  
  def child_list
    @parents = Category.all.order("id ASC").limit(13)
  end

  def grandchild_list
    @parents = Category.all.order("id ASC").limit(13)
  end

end
