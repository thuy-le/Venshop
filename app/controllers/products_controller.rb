class ProductsController < ApplicationController
  # GET /products
  # GET /products.json
  def index
    initialize
    @products = Product.all
    #initialize
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    @categories = Category.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    logger.debug 'oooooooooooooooooooooooooooooooooooooooooooooooooo'
    logger.debug product_params[:category_id]
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def product_params
    params.require(:product).permit(:category_id, :currency, :description, :imgurl, :name, :price, :user_id)

  end

  def initialize
    if Product.count > 0 then return
    end
    @categories = Category.all
    @categories.each do |cat|
    #cat = @categories[0]
    url = 'http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=dj0zaiZpPXpIMzBsMUQyTk55dSZkPVlXazlZWGxzYjNoWU0yVW1jR285TUEtLSZzPWNvbnN1bWVyc2VjcmV0Jng9MzI-&category_id=' + cat.category_id.to_s
    buffer = URI.parse(url).read()
    result = JSON.parse(buffer)
    for i in 0..20

      begin
        product = Product.new
        product.user_id = 0;
        product.category_id = cat.category_id
        p = result["ResultSet"]["0"]["Result"][i.to_s]
        product.name = p["Name"]
        product.imgurl = p["Image"]["Small"]
        product.price = p["Price"]["_value"]
        product.currency = p["Price"]["_attributes"]["currency"]
        product.description = p["Description"]
        product.save
      rescue
      end

    end

    end

  end

end
