class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # added rescue_from


  def index
    authors = Author.all
    render json: authors
  end

  def show
    author = Author.find(params[:id])
    render json: author
  end

  def create
    author = Author.create(author_params)
    render json: author, status: :created
  rescue ActiveRecord::RecordInvalid => invalid
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

  private
  
  def author_params
    params.permit(:email, :name)
  end

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end
  
end
