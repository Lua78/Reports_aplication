class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

 
  def new
    @category = Category.new
  end

  def edit
     category
  end


  def create
    @category = Category.new(category_params)

      if @category.save
    redirect_to categories_path, notice: "Categoria creada correctamente." 
      else
        render :new, status: :unprocessable_entity 
      end
  end

  def update
      if category.update(category_params)
        redirect_to categories_path, notice: "Categoria actualizada correctamente." 
      else
       render :edit, status: :unprocessable_entity 
      end
  end

  def destroy
    if category.destroy
     redirect_to categories_url, notice: "Categoria eliminada correctamente." 
    end
  end

  private
    def category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
