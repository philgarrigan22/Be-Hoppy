require 'httparty'

class ReviewsController < ProtectedController
  before_action :set_review, only: %i[show update destroy]

  def search_beer
    search_beer = params.require(:search)
    render json: HTTParty.get("https://data.opendatasoft.com//api/records/1.0/search/?dataset=open-beer-database%40public-us&q=#{search_beer}&facet=style_name&facet=cat_name&facet=name_breweries&facet=country")
  end

  # YELP POST search for Brewery by location
  def yelp_search
    location = params.require(:search)
    render json: HTTParty.get("https://api.yelp.com/v3/businesses/search?limit=50&term=Breweries&location=#{location}", :headers => { "Authorization" => "Bearer #{ENV["YELP_KEY"]}"})
  end

  # GET /reviews
  def index
    @reviews = current_user.reviews.all

    render json: @reviews
  end

  # GET /reviews/1
  def show
    render json: @review
  end

  # POST /reviews
  def create
    @review = current_user.reviews.build(review_params)

    if @review.save
      render json: @review, status: :created, location: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = current_user.reviews.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def review_params
      params.require(:review).permit(:beer, :brewery, :rating, :location, :beer_type, :flavor)
    end
end
