class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    flash.now[:notice] = "We have exactly #{@kittens.size} kittens registered."
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kittens }
    end
  end
  def new
    @kitten = Kitten.new 
  end
  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      redirect_to @kitten , notice: "Congrats, you have successfully registered your cat"
    else
      render :new, status: :unprocessable_entity, notice: "Error, something went wrong"
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kitten }
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to @kitten , notice: "Congrats, you have successfully updated information of your cat"
    else
      render :edit, status: :unprocessable_entity , notice: "Error, something went wrong"
    end
  end
  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    redirect_to root_path, status: :see_other, notice: "You have successfully deleted your kitten"
  end
  private
    def kitten_params
      params.require(:kitten).permit(:name, :age , :cuteness , :softness)
    end
end
