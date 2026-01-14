class ItemsController < ApplicationController
  
  # アクション
  def index
  end

  def new
    @item = Item.new
  end

end
