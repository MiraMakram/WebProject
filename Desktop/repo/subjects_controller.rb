class SubjectsController < ApplicationController

  layout false 

  def index
    @subjects = Subject.sorted 
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new(:name => "default") 
  end

  def create 
    # instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    #save the object
    if @subject.save
      #if save succeeds , redirect to the index action
      flash[:notice] = "subject created successfully."
      redirect_to(:action => 'index')
    else
      # if save fails , redisplay the form so that the user can fix problems
      render('new')
    end
    
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # find an existing object using form parameters
    @subject = Subject.find(params[:id])
    #update the object
    if @subject.update_attributes(subject_params)
      #if update succeeds , redirect to the index action
      flash[:notice] = "subject updated successfully."
      redirect_to(:action => 'show', :id => @subject.id )
    else
      # if update fails , redisplay the form so that the user can fix problems
      falsh[:error] = "Error !! can't update subject"
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "subject '#{subject.name}' deleted successfully."
    redirect_to(:action => 'index')
  end
  private 
    def subject_params
      params.require(:subject).permit(:name, :position, :visible)
    end
end
