#encoding: utf-8
class OffersController < ApplicationController
  layout 'profile'
  
  before_filter :authenticate_user!, only: 'index'
  before_filter :check_is_picker, only: 'index'
  
  def index
    @offers = Offer.where('published IS true AND user_id != ?', [current_user.id]).group_by(&:location_string)
    render layout: 'full_map'
  end
  
  def new
    @offer = Offer.new
  end
  
  def create
    @offer = Offer.new_with(offer_params, current_user)
    if @offer.save
      if user_signed_in?
        flash[:notice] = "Tu reciclable está guardado, solo falta publicarlo"
        redirect_to user_activity_path(current_user.id).concat('#/unpublished')
      else
        flash[:notice] = "Para que un recolector te contacte, es necesario registrarse"
        session[:pending_offer] = @offer.id
        redirect_to new_user_registration_path
      end
    else
      render action: 'new'
    end
  end
  
  def destroy
    @offer = Offer.find(params[:id])
    if @offer.destroy
      flash[:notice] = "Tu reciclable ha sido eliminado"
    else
      flash[:error] = "No fué posible eliminar tu reciclable"
    end
    redirect_to user_activity_path(current_user.id)
  end
  
  def toggle_visibility
    @offer = Offer.find(params[:id])
    if !@offer.has_appointments? and !@offer.published
      flash[:error] = "Tu reciclable no puede ser publicado sin que tenga fechas para su recolección"
      redirect_to user_activity_path(current_user.id).concat('#/unpublished')
    else 
      @offer.update_attribute(:published, !@offer.published)
      if @offer.published
        flash[:notice] = "Tu reciclable está publicado ahora"
      else
        flash[:notice] = "Tu reciclable ha sido sacado de publicación y nadie lo verá"
      end
      redirect_to user_activity_path(current_user.id)
    end
    

  end
  
  private

  def offer_params
    params.require(:offer).permit(
      :kind, 
      :quantity, 
      :details, 
      :location_id,
      :user_id,
      :published,
      :quantifiable_type,
      :offer_image,
      appointments: [:meeting_time, :notes],
      location: [:coordinates_lat, :coordinates_lon, :address]
    )
  end
  
  def check_is_picker
    current_user.is_a_picker?
  end
end
