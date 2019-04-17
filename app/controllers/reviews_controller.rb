class ReviewsController < ProtectedController
  before_action :set_review, only: [:show, :update, :destroy]

  require 'httparty'

  # YELP POST search for Brewery by location
  def find_breweries
    search_location = params.require(:search)
    headers = { 'Authorization' => "Bearer #{ENV['YELP_KEY']}" }
    @res = HTTParty.get(
      'https://api.yelp.com/v3/businesses/search',
      headers: headers,
      query: { term: 'Breweries', location: search_location }
    )

    render json: @res
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
