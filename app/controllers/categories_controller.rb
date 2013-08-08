require 'open-uri'
require 'json'

class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json

  layout "layouts/application"

  def index
    if(Category.count < 5)
      initialize
    end
    @categories = Category.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])
    @products = Product.find_by_category_id(params[:id])
 end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def category_params
      params.require(:category).permit(:category_id, :name)
    end

    def initialize
#      Category.destroy_all

    if Category.count >=5 then return
    end
      logger.debug '+++++++++++++++++++++++++++++++++++++++++++'
      i = 0;
      k = 0;
      while(i < 5)
        k = k + 2
        url = 'http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=dj0zaiZpPXpIMzBsMUQyTk55dSZkPVlXazlZWGxzYjNoWU0yVW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MzI-&category_id=' + k.to_s
        buffer = URI.parse(url).read()
        result = JSON.parse(buffer)
        r = result["ResultSet"]["0"]["Result"]["0"]["Category"]
        if !r.nil?
          i = i + 1
          cate = Category.new
          cate.category_id = r["Current"]["Id"]
          cate.name = r["Current"]["Name"]
          begin
          cate.save
          rescue

          end
          logger.debug '------------------------------------------------------------'
          logger.debug r["Current"]["Name"]
        end
      end
    end

end
